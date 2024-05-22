#############################
##creating bucket for s3 backend
#########################

resource "aws_s3_bucket" "terraform-state" {
  bucket = "project-18-pbl"
  force_destroy = true
}
resource "aws_s3_bucket_versioning" "version" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "first" {
  bucket = aws_s3_bucket.terraform-state.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
# Creating VPC
module "VPC" {
    source                               = "./modules/VPC"
    region                               = var.region
    vpc_cidr                             = var.vpc_cidr
    enable_dns_support                   = var.enable_dns_support
    enable_dns_hostnames                 = var.enable_dns_hostnames
    preferred_number_of_public_subnets   = var.preferred_number_of_public_subnets
    preferred_number_of_private_subnets  = var.preferred_number_of_private_subnets
    private_subnets                      = [for i in range (1, 8, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
    public_subnets                       = [for i in range (2, 5, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
    name                                 = var.name
    tags                                 = var.tags
    environment                          = var.environment
  
}

module "Security" {
    source = "./modules/Security"
    vpc_id = module.VPC.vpc_id
    tags = var.tags
  
}

module "ALB" {
    source                          = "./modules/ALB"
    vpc_id                          = module.VPC.vpc_id
    public-sg                       = module.Security.ALB-sg
    private-sg                      = module.Security.IALB-sg
    public-sub-1                    = module.VPC.public_subnets-1
    public-sub-2                    = module.VPC.public_subnets-2
    private-sub-1                   = module.VPC.private_subnets-1
    private-sub-2                   = module.VPC.private_subnets-2
    load_balancer_type              = "application"
    ip_address_type                 = "ipv4"
    tags                            = var.tags
    path                            = "/healthstatus"
    interval                        = 10
    protocol                        = "HTTPS"
    timeout                         = 5
    healthy_threshold               = 5
    unhealthy_threshold             = 2
    target_type                     = "instance"
    priority                        = 99
    values                          = "tooling.toolingibk.site"
}

module "Autoscaling" {
    source                          = "./modules/Autoscaling"
    ami-web                         = var.ami
    ami-bastion                     = var.ami
    ami-nginx                       = var.ami
    min_size                        = 1
    max_size                        = 2
    desired_capacity                = 1
    web-sg                          = [module.Security.web-sg]
    bastion_sg                      = [module.Security.bastion_sg]
    nginx-sg                        = [module.Security.nginx-sg]
    wordpress-tgt-alb               = module.ALB.wordpress-tgt
    nginx-tgt-alb                   = module.ALB.nginx-tgt
    tooling-tgt-alb                 = module.ALB.tooling-tgt
    instance_profile                = module.VPC.instance_profile
    public_subnets                  = [module.VPC.public_subnets-1, module.VPC.public_subnets-2]
    private_subnets                 = [module.VPC.private_subnets-1, module.VPC.private_subnets-2]
    keypair                         = var.keypair
    health_check_grace_period       = 300
    health_check_type               = "ELB"
        
    }

    module "EFS" {
        source                      = "./modules/EFS"
        efs-subnet-1                = module.VPC.private_subnets-1
        efs-subnet-2                = module.VPC.private_subnets-2
        efs-sg                      = [module.Security.datalayer-sg]
        account_no                  = var.account_no
      
    }

    module "RDS" {
        source = "./modules/RDS"
        identifier                  = "bankycs-rds"
        db-username                 = var.master-username
        db-password                 = var.master-password
        db-sg                       = [module.Security.datalayer-sg]
        private_subnets             = [module.VPC.private_subnets-3, module.VPC.private_subnets-4]
        allocated_storage           = 20
        # storage_type                = "gp2"
        engine                      = "mysql"
        engine_version              = "8.0"
        instance_class              = "db.t3.micro"
        parameter_group_name        = "default.mysql8.0"
        # multi_az                    = "true"
      
    }

    module "compute" {
        source = "./modules/compute"
        ami-jenkins = var.ami
        ami-sonar = var.ami
        ami-jfrog = var.ami
        subnets-compute = module.VPC.public_subnets-1
        sg-compute = [module.Security.ALB-sg]
        keypair = var.keypair
        tags = var.tags
      
    }