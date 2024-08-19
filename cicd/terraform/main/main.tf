
module "codepipeline" {
  source = "modules/codepipeline"
  environment = var.environment
  project_name = var.project_name
  s3_bucket_cicd = var.s3_bucket_cicd
  bitbucket_location = var.bitbucket_location
  codestar_connection = var.codestar_connection
  codepipeline_service_role_arn = var.codepipeline_service_role_arn
  codebuild_service_role_arn = var.codebuild_service_role_arn
}
