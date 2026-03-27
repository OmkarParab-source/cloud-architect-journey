resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-vpc"
    Component = "vpc"
  })
}
