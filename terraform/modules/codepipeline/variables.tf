variable "environment" {
  type = string
  description = "Deploy Environment."
  validation {
      condition = contains(["DEV", "STG", "PRD"], var.environment)
      error_message = "The environment must be one of DEV, STG, or PRD."
  }

}

variable "project_name" {
  type = string
  description = "Project Name"
}

variable "s3_bucket_cicd" {
  type = string
  description = "Bucket that will be used for CI/CD."
}

variable "codestart_connection" {
  type = string
  description = "arn of codestart connection."
}

variable "bitbucket_location" {
  type = string
  description = "Location of the repo in bitbucket."
}

variable "codepipeline_service_role_arn" {
  type = string
  description = "CodePipeline Service Role ARN"
}

variable "codebuild_service_role_arn" {
  type = string
  description = "CodeBuild Service Role ARN"
}