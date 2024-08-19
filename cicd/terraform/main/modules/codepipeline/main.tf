resource "aws_codepipeline" "codepipeline" {
  name     = "${var.environment}-${var.project_name}-codepipeline"
  role_arn = var.codepipeline_service_role_arn

  artifact_store {
    location = var.s3_bucket_cicd
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.codestar_connection
        FullRepositoryId = var.bitbucket_location
        BranchName       = var.environment
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.codebuild.name
        EnvironmentVariables = jsonencode(
          [
            {
              name: "S3BucketName"
              type: "PLAINTEXT"
              value: var.s3_bucket_cicd
            },
            {
              name: "ProjectName"
              type: "PLAINTEXT"
              value: var.project_name
            }
          ]
        )
      }
    }
  }

  stage {
    name = "Create-ChangeSets-Lambdas"

    action {
      name            = "Create-ChangeSet-Lambda"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration = {
        ActionMode     = "CHANGE_SET_REPLACE"
        Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM,CAPABILITY_NAMED_IAM"
        ChangeSetName  = "${var.environment}-${var.project_name}-ChangeSet"
        StackName      = "${var.environment}-${var.project_name}"
        TemplatePath   = "BuildArtifact::out-${var.project_name}-lambda.yaml"
        RoleArn        = var.codebuild_service_role_arn
        ParameterOverrides = jsonencode(
          {
            Environment : var.environment
          }
        )
      }
    }

  }

  stage {
    name = "Execute-ChangeSet-Lambdas"

    action {
      name            = "Execute-ChangeSet-Lambda"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CloudFormation"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration = {
        ActionMode    = "CHANGE_SET_EXECUTE"
        Capabilities  = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM,CAPABILITY_NAMED_IAM"
        ChangeSetName = "${var.environment}-${var.project_name}-ChangeSet"
        StackName     = "${var.environment}-${var.project_name}"
      }
    }
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
    IaC         = "Terraform"
  }
}


# CODEBUILD

resource "aws_codebuild_project" "codebuild" {
  name          = "${var.environment}-${var.project_name}-codebuild"
  build_timeout = "20"
  service_role  = var.codebuild_service_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-aarch64-standard:2.0"
    type                        = "ARM_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.environment}-${var.project_name}-codebuild-log"
      stream_name = "${var.environment}-${var.project_name}-codebuild-stream"
    }
  }

  source {
    type = "CODEPIPELINE"
    buildspec = "cicd/buildspec.yml"
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
    IaC         = "Terraform"
  }
}