terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.58.0"
    }    
  }
    backend "s3" {
    bucket = "sky-s3-main10"
    key    = "terraform/states/frogtech-rds/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    }

  #     cloud {
  #   organization = "DevopsKitchenWorkshop"

  #   workspaces {
  #     name = "Dev_workspace"
  #     project = "Workspace_configs"
  #   }

  # }
}
# Configure aws provider
provider "aws" {
  region = "us-east-1"
}
