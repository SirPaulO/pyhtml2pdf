variable "environment" {
  type = string
  description = "Deploy Environment."
  default = "DEV"
  validation {
      condition = contains(["DEV", "STG", "UAT", "LIVE"], var.environment)
      error_message = "The environment must be one of DEV, STG, UAT, LIVE"
  }
}

variable "project_name" {
  type = string
  description = "Project Name"
}

variable "codepipeline_service_role_arn" {
  type = string
  description = "CodePipeline Service Role ARN"
}

variable "codebuild_service_role_arn" {
  type = string
  description = "CodeBuild Service Role ARN"
}

variable "s3_bucket_cicd" {
  type = string
  description = "Bucket that will be used for CI/CD."
}

variable "codestar_connection" {
  type = string
  description = "arn of codestar connection."
}

variable "bitbucket_location" {
  type = string
  description = "Location of the repo in bitbucket."
}
