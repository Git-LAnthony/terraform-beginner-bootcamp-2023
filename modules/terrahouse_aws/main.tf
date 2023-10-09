terraform {

  # cloud {
  #   organization = "ResumeApp"
  #   workspaces {
  #     name = "terra_house_1"
  #   }
  # }

  required_providers {
    
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

#  provider "aws" {
#    # Configuration options
#  }


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity
#This is referenced in the s3 bucket access policy
data "aws_caller_identity" "current" {

}