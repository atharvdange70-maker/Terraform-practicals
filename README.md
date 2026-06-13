# Terraform-module-folder

Terraform project for provisioning AWS infrastructure with reusable modules and environment-specific configurations.

## Overview

This repository is organized around a root environment layer under `env/` and reusable Terraform modules under `modules/`.

The current stack provisions:

- A VPC with public and private subnets
- Security groups
- An Application Load Balancer
- EC2 instances managed through Auto Scaling groups
- IAM roles and policy attachments

## Repository Structure

```text
README.md
env/
	dev/
		main.tf
		terraform.tfstate
		terraform.tfstate.backup
		Test/
			main.tf
			output.tf
			uat.auto.tfvars
			variable.tf
modules/
	Alb/
	Autoscaling_group/
	iam/
	instance/
	Security_group/
	vpc/
```

## Prerequisites

- Terraform installed locally
- AWS CLI configured with the profile `terraform-sessions`
- Access to the AWS region `eu-west-1`

## Usage

Run Terraform from the environment directory you want to deploy.

```bash
cd env/dev
terraform init
terraform plan
terraform apply
```

If you are working in the `Test` environment, run the same commands inside `env/dev/Test`.

## Configuration

The main environment file currently wires these module inputs:

- VPC CIDR and subnet CIDRs
- Availability zones
- Tags
- Application and environment names
- Instance type and Auto Scaling group sizing

Example variables are defined in the environment `variable.tf` file.

## Outputs

The root environment exposes useful outputs including:

- ALB DNS name
- Auto Scaling group names
- Target group ARNs

## Notes

- The repository already contains Terraform state files under `env/dev/`. Consider moving state to a remote backend before using this for shared deployments.
- Module names in the repository use the existing folder casing, so keep source paths aligned with the current directory names.