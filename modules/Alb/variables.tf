variable "tags" {
  type = map(string)
  default = {}
}

variable "vpc_id" {
type = string
}

variable "public_subnet_ids" {
  type = list(string)
  
}
 variable "alb" {
  type = string
   
 }

variable "alb_security_group_id" {
  description = "Security Group ID"
  type        = string
}

variable "ingress" {
  type = list(number)
}

variable "target_groups" {
  description = "List of target group names"
  type        = map(number)

  default = {
    home-tg   = 8080 
    laptop-tg = 8081
    mobile-tg = 8082
  }
}

