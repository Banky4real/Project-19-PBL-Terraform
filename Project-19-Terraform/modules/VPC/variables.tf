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

variable "private_subnets" {
    type = list(any)
    description = "List of Private Subnets"
  
}

variable "public_subnets" {
    type = list(any)
    description = "List of Public subnets"
  
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