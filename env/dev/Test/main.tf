provider "aws" {
  profile = "terraform-sessions"
  region  = "eu-west-1"
}

module "vpc" {
  source = "../../modules/vpc"
  application = var.application
  env = var.env
  vpc_cidr = var.vpc_cidr
  private_subnet = var.private_subnet
  public_subnet = var.public_subnet
  tags = var.tags
}

module "alb" {
  source = "../../modules/alb"
  vpc_id   = module.vpc.main.id  
security_groups    = aws_security_group.alb_sg.id
subnets = var.public_subnet_ids
 tags = var.tags
}

module "security_groups" {
  source = "../../modules/alb"
  vpc_id   = module.vpc.main.id  
  ingress_ports  = var.ingress_ports
  cidr_blocks    = var.cidr_blocks
}

module "asg" {
  source                  = "../../modules/asg"
  private_subnet_ids      = module.vpc.private-subnet-ids
  ec2_security_group_id   = module.security_groups.ec2_security_group_id
  laptop_target_group_arn = module.alb.laptop_target_group_arn
  mobile_target_group_arn = module.alb.mobile_target_group_arn
  home_target_group_arn   = module.alb.home_target_group_arn
  instance_type           = var.instance_type
  desired_capacity        = var.desired_capacity
  max_size                = var.max_size
  min_size                = var.min_size
  name_prefix             = var.name_prefix
  tags                    = var.tags
}
