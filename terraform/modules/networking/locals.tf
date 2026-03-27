locals {
  name_prefix = "${var.project}-${var.environment}"

  azs = slice(data.aws_availability_zones.available.names, 0, 2)
  az_map = {
    "az-a" = local.azs[0]
    "az-b" = local.azs[1]
  }

  # Map az_key to public subnet name for easy lookup when creating NAT Gateway
  public_subnet_by_az = {
    for key, subnet in var.public_subnets :
    subnet.az_key => key
  }
}
