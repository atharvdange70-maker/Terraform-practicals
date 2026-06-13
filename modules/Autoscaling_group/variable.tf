variable "private_subnet_ids" {
  description = "List of private subnet IDs for ASGs"
  type        = list(string)
}

variable "ec2_security_group_id" {
  description = "Security group ID for EC2 instances"
  type        = string
}

variable "laptop_target_group_arn" {
  description = "ARN of the laptop target group"
  type        = string
}

variable "mobile_target_group_arn" {
  description = "ARN of the mobile target group"
  type        = string
}

variable "home_target_group_arn" {
  description = "ARN of the home target group"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "desired_capacity" {
  description = "Desired number of instances in ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in ASG"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum number of instances in ASG"
  type        = number
  default     = 1
}

variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "terraform"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}