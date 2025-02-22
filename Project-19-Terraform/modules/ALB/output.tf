output "alb_dns_name" {
  value = aws_lb.ext-alb.dns_name
}

output "nginx-tgt" {
  description = "External Load Balancer Target Group"
  value       = aws_lb_target_group.nginx-tgt.arn
  
}

output "wordpress-tgt" {
  description = "wordpress target group"
  value       = aws_lb_target_group.wordpress-tgt.arn
  
}

output "tooling-tgt" {
  description = "tooling target group"
  value       = aws_lb_target_group.tooling-tgt.arn
}

# output "alb_target_group_arn" {
#   value = aws_lb_target_group.nginx-tgt.arn
# }