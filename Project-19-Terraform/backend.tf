# terraform {
#   backend "s3" {
#     bucket         = "project-18-pbl"
#     key            = "global/s3/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }
