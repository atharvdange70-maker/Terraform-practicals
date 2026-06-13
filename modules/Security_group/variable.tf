variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
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

variable "ingress" {
  default = {
    ssh = {
      port        = "22"
      protocol    = "tcp"
      cidr_block  = ["0.0.0.0/0"]
      description = "This is for each"
    },
    http = {
      port        = "80"
      protocol    = "tcp"
      cidr_block  = ["0.0.0.0/0"]
      description = "This is for htto"
    },
    https = {
      port        = "443"
      protocol    = "tcp"
      cidr_block  = ["0.0.0.0/0"]
      description = "This is for https"
    },
  }
}

variable "egress" {
  default = {
    all_traffic = {
      port        = 0
      protocol    = "-1"
      description = "allow all traffic"
      cidr_block  = ["0.0.0.0/0"]
    }
  }

}