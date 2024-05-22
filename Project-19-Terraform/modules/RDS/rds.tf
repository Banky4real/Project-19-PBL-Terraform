# create DB subnet group from the private subnets
resource "aws_db_subnet_group" "BANKYCS-rds" {
  name       = "bankycs-rds"
  subnet_ids = var.private_subnets

   tags = merge(
    var.tags,
    {
      Name = "BANKYCS-rds"
    },
  )
}

# create the RDS instance with the subnets group
resource "aws_db_instance" "BANKYCS-rds" {
  identifier             = var.identifier
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  username               = var.db-username
  password               = var.db-password
  db_subnet_group_name   = aws_db_subnet_group.BANKYCS-rds.name
  vpc_security_group_ids = var.db-sg
  parameter_group_name   = var.parameter_group_name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
# resource "aws_db_instance" "BANKYCS-rds" {
#   allocated_storage      = var.allocated_storage
#   storage_type           = var.storage_type
#   engine                 = var.engine
#   engine_version         = var.engine_version
#   instance_class         = var.instance_class
#   username               = var.db-username
#   password               = var.db-password
#   parameter_group_name   = var.parameter_group_name
#   db_subnet_group_name   = aws_db_subnet_group.BANKYCS-rds.name
#   skip_final_snapshot    = true
#   vpc_security_group_ids = var.db-sg
#   multi_az               = var.multi_az
# }