module "vpc" {
  source = "./modules/vpc"

  project     = local.project
  environment = local.environment
  common_tags = local.common_tags

  vpc_cidr = "10.0.0.0/16"
}

module "networking" {
  source = "./modules/networking"

  project     = local.project
  environment = local.environment
  common_tags = local.common_tags

  vpc_id = module.vpc.vpc_id

  public_subnets = {
    public-subnet-1 = { cidr = "10.0.1.0/24", az_key = "az-a" },
    public-subnet-2 = { cidr = "10.0.3.0/24", az_key = "az-b" }
  }
  private_subnets = {
    private-subnet-1 = { cidr = "10.0.2.0/24", az_key = "az-a" },
    private-subnet-2 = { cidr = "10.0.4.0/24", az_key = "az-b" }
  }
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
  tags   = local.common_tags
}
