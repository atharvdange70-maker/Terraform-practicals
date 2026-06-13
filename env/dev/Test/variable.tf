variable "tags" {
  type = map(string)
  default = {
    "Organization" = "iata"
    "Owner"        = "atul"
    "Environment"  = "dev"
  }

}

variable "vpc_cidr" {
  type        = string
  description = "Give your vpc cidr"
}

variable "private_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24"]
  description = "Give your subnet cidr values in list format"


}

variable "public_subnet_cidr" {
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  description = "Give your subnet cidr for public subnet here"
}

variable "name_prefix" {
  type        = string
  default     = "terraform-dev"
  description = "Prefix for naming resources"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type for EC2 instances"
}

variable "desired_capacity" {
  type        = number
  default     = 1
  description = "Desired number of instances in ASG"
}

variable "max_size" {
  type        = number
  default     = 3
  description = "Maximum number of instances in ASG"
}

variable "min_size" {
  type        = number
  default     = 1
  description = "Minimum number of instances in ASG"
}

variable "application" {
  type = string
}

variable "env" {
  type = string
}