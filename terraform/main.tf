module "vpc" {
  source = "./modules/vpc"

  name_prefix = local.name_prefix
  cidr_block  = var.vpc_cidr
}

module "networking" {
  source = "./modules/networking"

  name_prefix = local.name_prefix
  vpc_id      = module.vpc.vpc_id

  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  nat_per_az = var.nat_per_az

  alb_security_group_ids = [
    module.security.alb_security_group_id
  ]
}

module "security" {
  source = "./modules/security"

  name_prefix = local.name_prefix
  vpc_id      = module.vpc.vpc_id
}

module "compute" {
  source = "./modules/compute"

  name_prefix = local.name_prefix

  private_subnet_ids = module.networking.private_subnet_ids
  target_group_arn   = module.networking.target_group_arn

  ec2_security_group_id = module.security.ec2_security_group_id
  instance_profile_name = module.security.instance_profile_name

  ami_id        = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type

  asg_min     = var.asg_min
  asg_desired = var.asg_desired
  asg_max     = var.asg_max

  target_cpu_utilization = var.target_cpu_utilization
}

# module "observability" {
#   source = "./modules/observability"

#   project     = local.project
#   environment = local.environment
#   common_tags = local.common_tags

#   target_group_arn_suffix = module.alb.target_group_arn_suffix
#   alb_arn_suffix          = module.alb.alb_arn_suffix
# }
