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

# module "compute" {
#   source = "./modules/compute"

#   project     = local.project
#   environment = local.environment
#   common_tags = local.common_tags

#   private_subnet_ids = module.networking.private_subnet_ids
#   web_sg_id          = module.security.web_sg_id
#   target_group_arn   = module.alb.target_group_arn
# }

# module "observability" {
#   source = "./modules/observability"

#   project     = local.project
#   environment = local.environment
#   common_tags = local.common_tags

#   target_group_arn_suffix = module.alb.target_group_arn_suffix
#   alb_arn_suffix          = module.alb.alb_arn_suffix
# }
