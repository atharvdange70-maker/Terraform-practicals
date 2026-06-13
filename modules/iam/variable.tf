variable "role_name" {
  type = string

}

variable "resource_type" {
  type = string

  validation {
    condition = contains(
      ["ec2", "lambda", "eks"],
      var.resource_type
    )

    error_message = "Invalid Resource type use [ec2,lambda,eks] "
  }
}

variable "access_level" {
  type = string

  validation {
    condition = contains(
      ["admin", "readonly"],
      var.access_level
    )
    error_message = "acess_level [admin,readonly] "
  }

}