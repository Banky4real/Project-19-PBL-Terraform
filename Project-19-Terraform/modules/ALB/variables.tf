# Security Group for External Load Balancer
variable "public-sg" {
    description = "Security group for external load balancer"
  
}

# The Public Subnet Group for External Load Balancer

variable "public-sub-1" {
    description = "Public subnets to deploy external ALB"
  
}
variable "public-sub-2" {
    description = "Public subnets to deploy external ALB"
  
}

variable "vpc_id" {
    type = string
    description = "ID of the VPC"
  
}

variable "private-sg" {
    description = "Security group for Internal Load Balancer"
  
}
variable "private-sub-1" {
    description = "Private subnets to deploy internal ALB"
  
}
variable "private-sub-2" {
    description = "Private subnets to deploy Internal ALB"
  
}

variable "ip_address_type" {
    type = string
    description = "IP address for the ALB"
  
}

variable "load_balancer_type" {
    type = string
    description = "The type of Load Balancer"
  
}

variable "tags" {
    description = "A mapping of tags to assign to all resources."
    type = map(string)
    default = {}
  
}
# variable "name" {
#     type = string
#     description = "name of the load balancer"
  
# }
variable "path" {
    type = string
  
}
variable "interval" {
    type = number
  
}
variable "protocol" {
    type = string
    description = "ip address protocol for load balancer"
  
}
variable "timeout" {
    type = number
  
}
variable "healthy_threshold" {
    type = number
  
}
variable "unhealthy_threshold" {
    type = number
  
}
variable "target_type" {
    type = string
    description = "target group type"
  
}
# listener variables
# variable "type" {
#     type = string
#     description = "listener type"  
# }
variable "priority" {
    type = number
  
}
variable "values" {
    type = string
    description = "value for listener host header condition"
  
}