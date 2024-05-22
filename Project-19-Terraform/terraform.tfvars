region = "us-east-1"

vpc_cidr = "10.0.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

enable_classiclink = "false"

enable_classiclink_dns_support = "false"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

environment = "dev"

ami = "ami-0cd59ecaf368e5ccf"

keypair = "PBL2"

account_no = "654654219187"

master-username = "banky"
master-password = "bankypblproject"

tags = {
  Owner-Email     = "ibukunolu.banky@gmail.com"
  Managed-By      = "Terraform"
  Billing-Account = "654654219187"
}
