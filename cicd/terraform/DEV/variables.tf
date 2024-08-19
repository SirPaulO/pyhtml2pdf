variable "environment" {
  type = string
  description = "Deploy Environment."
  default = "DEV"
  validation {
      condition = contains(["DEV"], var.environment)
      error_message = "The environment must be DEV"
  }
}

variable "project_name" {
  type = string
  description = "Project Name"
  default = "html2pdf"
}

variable "codepipeline_service_role_arn" {
  type = string
  description = "CodePipeline Service Role ARN"
  default = "arn:aws:iam::616962414855:role/codepipeline-service-role"
}

variable "codebuild_service_role_arn" {
  type = string
  description = "CodeBuild Service Role ARN"
  default = "arn:aws:iam::616962414855:role/service-role/codebuild-service-role"
}

variable "s3_bucket_cicd" {
  type = string
  description = "Bucket that will be used for CI/CD."
  default = "dev-kaptur-cicd-tasks"
}

variable "codestar_connection" {
  type = string
  description = "arn of codestar connection."
  default = "arn:aws:codestar-connections:eu-west-2:616962414855:connection/a977c8a7-a99e-4a11-a71a-68ab69583c6a"
}

variable "bitbucket_location" {
  type = string
  description = "Location of the repo in bitbucket."
  default = "nlgo/html2pdflambda"
}
