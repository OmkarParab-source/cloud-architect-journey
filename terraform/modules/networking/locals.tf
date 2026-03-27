locals {
  name_prefix = "${var.project}-${var.environment}"

  azs = slice(data.aws_availability_zones.available.names, 0, 2)
  az_map = {
    "az-a" = local.azs[0]
    "az-b" = local.azs[1]
  }
}
