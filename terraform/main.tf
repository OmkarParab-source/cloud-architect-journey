module "vpc" {
  source   = "./modules/vpc"
  vpc_name = "prod-vpc"
  vpc_cidr = "10.0.0.0/16"

  tags = local.common_tags
}
