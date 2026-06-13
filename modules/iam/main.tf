locals {
  service_principals = {
    ec2    = "ec2.amazonaws.com"
    lambda = "lambda.amazonaws.com"
    eks    = "eks.amazonaws.com"
  }

  access_policies = {
    admin    = "arn:aws:iam::aws:policy/AdministratorAccess"
    readonly = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        local.service_principals[var.resource_type]
      ]
    }
  }
}

resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = data.aws_iam_policy_document.assume_role.json

}

resource "aws_iam_role_policy_attachment" "this" {
  role = aws_iam_role.this.name

  policy_arn = local.access_policies[var.access_level]

}