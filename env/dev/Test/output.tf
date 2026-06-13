output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "laptop_asg_name" {
  description = "Name of the laptop Auto Scaling Group"
  value       = module.asg.laptop_asg_name
}

output "mobile_asg_name" {
  description = "Name of the mobile Auto Scaling Group"
  value       = module.asg.mobile_asg_name
}

output "home_asg_name" {
  description = "Name of the home Auto Scaling Group"
  value       = module.asg.home_asg_name
}

output "laptop_target_group_arn" {
  description = "ARN of the laptop target group"
  value       = module.alb.laptop_target_group_arn
}

output "mobile_target_group_arn" {
  description = "ARN of the mobile target group"
  value       = module.alb.mobile_target_group_arn
}

output "home_target_group_arn" {
  description = "ARN of the home target group"
  value       = module.alb.home_target_group_arn
}