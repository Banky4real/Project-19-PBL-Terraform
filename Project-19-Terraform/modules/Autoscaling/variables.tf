variable "ami-web" {
    type = string
    description = "ami for webservers"
  
}

variable "instance_profile" {
    type = string
    description = "instance profile for launch template"
  
}

variable "keypair" {
    type = string
    description = "keypair for instances"
  
}

variable "ami-bastion" {
    type = string
    description = "ami for bastion"
  
}

variable "web-sg" {
    type = list(string)
    description = "security group for webservers"
  
}

variable "bastion_sg" {
    type = list(string)
    description = "security group for bastion"
  
}

variable "nginx-sg" {
    type = list(string)
    description = "security group for nginx"
  
}

variable "private_subnets" {
    type = list(string)
    description = "first private subnets for internal ALB"
  
}

variable "public_subnets" {
    type = list(string)
    description = "second subnet for external ALB"
  
}

variable "ami-nginx" {
    type = string
    description = "ami for nginx"
  
}

variable "nginx-tgt-alb" {
    type = string
    description = "nginx reverse proxy target group"
  
}

variable "wordpress-tgt-alb" {
    type = string
    description = "wordpress target group"
  
}

variable "tooling-tgt-alb" {
    type = string
    description = "tooling target group"
  
}

variable "max_size" {
    type = number
    description = "maximum number for autoscaling"
  
}

variable "min_size" {
    type = number
    description = "minimum number for autoscaling"
  
}

variable "health_check_grace_period" {
    type = number
    description = "healthcheck for autoscaling group"
  
}

variable "health_check_type" {
    type = string
    description = "health check type for autoscaling"
  
}

variable "desired_capacity" {
    type = number
    description = "Desired number of instance in autoscaling group"
  
}

variable "tags" {
    description = "A mapping of tags to assign to all resources."
    type = map(string)
    default = {}
  
}