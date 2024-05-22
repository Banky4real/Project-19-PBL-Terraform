output "ALB-sg" {
  value = aws_security_group.BANKYCS["ext-alb-sg"].id
}


output "IALB-sg" {
  value = aws_security_group.BANKYCS["int-alb-sg"].id
}


output "bastion_sg" {
  value = aws_security_group.BANKYCS["bastion_sg"].id
}


output "nginx-sg" {
  value = aws_security_group.BANKYCS["nginx-sg"].id
}


output "web-sg" {
  value = aws_security_group.BANKYCS["webserver-sg"].id
}


output "datalayer-sg" {
  value = aws_security_group.BANKYCS["datalayer-sg"].id
}