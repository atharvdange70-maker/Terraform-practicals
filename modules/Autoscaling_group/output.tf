output "laptop_asg_name" {
  description = "Name of the laptop ASG"
  value       = aws_autoscaling_group.laptop_asg.name
}

output "mobile_asg_name" {
  description = "Name of the mobile ASG"
  value       = aws_autoscaling_group.mobile_asg.name
}

output "home_asg_name" {
  description = "Name of the home ASG"
  value       = aws_autoscaling_group.home_asg.name
}