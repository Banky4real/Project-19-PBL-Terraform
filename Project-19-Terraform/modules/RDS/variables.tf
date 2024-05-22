variable "db-username" {
    type = string
    description = "The master username"
  
}

variable "db-password" {
    type = string
    description = "Master Password"
  
}

variable "db-sg" {
    type = list(string)
    description = "The DB Security Group"
  
}

variable "private_subnets" {
    type = list(string)
    description = "Private Subnets for DB Subnet Group"
  
}

variable "allocated_storage" {
    type = number
    description = "DB Storage size"
  
}

# variable "storage_type" {
#     type = string
#     description = "Type of DB Storage"
  
# }

variable "engine" {
    type = string
    description = "Type of database engine"
  
}

variable "engine_version" {
    type = string
    default = "The Version of Database Engine"
  
}

variable "identifier" {
    type = string
    description = "Database Identifier"
  
}

variable "instance_class" {
    type = string
    description = "DB Instance Classification"
  
}

variable "parameter_group_name" {
    type = string
    description = " The Parameter Group Name for the DB Instance"
  
}

# variable "multi_az" {
#     type = string
#     description = "DB Availability Zone"
  
# }

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}