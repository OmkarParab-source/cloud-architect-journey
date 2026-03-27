module "vpc" {
  source = "./modules/vpc"

  project     = local.project
  environment = local.environment
  common_tags = local.common_tags

  vpc_cidr = "10.0.0.0/16"
}

module "networking" {
  source = "./modules/networking"

  vpc_id   = module.vpc.vpc_id
  vpc_name = "prod-vpc"
  env      = var.env
  tags     = local.common_tags

  public_subnets = [
    { name = "public-subnet-1", cidr = "10.0.1.0/24", az_key = "a" },
    { name = "public-subnet-2", cidr = "10.0.3.0/24", az_key = "b" }
  ]

  private_subnets = [
    { name = "private-subnet-1", cidr = "10.0.2.0/24", az_key = "a" },
    { name = "private-subnet-2", cidr = "10.0.4.0/24", az_key = "b" }
  ]
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
  tags   = local.common_tags
}
