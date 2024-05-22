terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


# Provider Block
provider "aws" {
  profile = "default"
  region  = var.region
}