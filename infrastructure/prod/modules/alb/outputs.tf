output "alb_dns_name" {
  value = aws_lb.ext-alb.dns_name
}

output "nginx-tgt" {
  description = "External Load balancaer target group"
  value       = aws_lb_target_group.nginx-tgt.arn
}


output "application-tgt" {
  description = "application target group"
  value       = aws_lb_target_group.application-tgt.arn
}
