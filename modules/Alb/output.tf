output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.app_lb.dns_name
}

output "laptop_target_group_arn" {
  description = "ARN of the laptop target group"
  value       = aws_lb_target_group.laptop_tg.arn
}

output "mobile_target_group_arn" {
  description = "ARN of the mobile target group"
  value       = aws_lb_target_group.mobile_tg.arn
}

output "home_target_group_arn" {
  description = "ARN of the home target group"
  value       = aws_lb_target_group.home_tg.arn
}