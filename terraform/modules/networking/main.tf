locals {
  public_subnet_ids  = [for s in aws_subnet.public : s.id]
  private_subnet_ids = [for s in aws_subnet.private : s.id]
}

module "alb" {
  source = "./alb"

  name_prefix        = var.name_prefix
  vpc_id             = var.vpc_id
  subnets            = local.public_subnet_ids
  security_group_ids = var.alb_security_group_ids
}
