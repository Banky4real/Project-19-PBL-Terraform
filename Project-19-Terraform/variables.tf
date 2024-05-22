variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "enable_dns_support" {
  default = "true"
}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "enable_classiclink" {
  default = "false"
}

variable "enable_classiclink_dns_support" {
  default = "false"
}

variable "preferred_number_of_public_subnets" {
  type = number
  description = "Number of private subnets"
  }

variable "preferred_number_of_private_subnets" {
  type = number
  description = "Number of private subnets"
}

variable "name" {
  type = string
  default = "BANKYCS"
}

variable "tags" {
  description   = "Mapping of Tags that will be assigned to all Resources."
  type          = map(string)
  default       = {}
}

variable "environment" {
  type = string
  description = "Environment"
}

variable "ami" {
  type = string
  description = "AMI ID for the Launch Template"
  
}

variable "keypair" {
  type = string
  description = "Key pair for the Instances"
  
}

variable "account_no" {
  type = number
  description = "IAM Account ID"

  }

  variable "master-username" {
    type = string
    description = "RDS admin username"
    
  }

  variable "master-password" {
    type = string
    description = "RDS admin password"
    
  }

# provider "aws" {
# region = var.region
# }



