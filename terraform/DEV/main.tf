terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "terraform-kaptur"
    key = "imagecropper.tfstate"
    region = "eu-west-2"
    dynamodb_table = "Terraform-lock-kaptur"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}

module "codepipeline" {
  source = "../modules/codepipeline"
  environment = var.environment
  project_name = var.project_name
  s3_bucket_cicd = var.s3_bucket_cicd
  bitbucket_location = var.bitbucket_location
  codestart_connection = var.codestart_connection
  codepipeline_service_role_arn = var.codepipeline_service_role_arn
  codebuild_service_role_arn = var.codebuild_service_role_arn
}

