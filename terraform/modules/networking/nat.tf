# MULTI-AZ NAT
resource "aws_eip" "nat_per_az" {
  for_each = var.nat_per_az ? var.public_subnets : {}

  domain = "vpc"

  tags = {
    Name  = "${var.name_prefix}-nat-eip-${each.key}"
    Layer = "networking"
  }
}

resource "aws_nat_gateway" "per_az" {
  for_each = var.nat_per_az ? var.public_subnets : {}

  allocation_id = aws_eip.nat_per_az[each.key].id
  subnet_id     = aws_subnet.public[each.key].id

  tags = {
    Name  = "${var.name_prefix}-nat-${each.key}"
    Layer = "networking"
  }
}

# SINGLE NAT
locals {
  first_public_az = keys(var.public_subnets)[0]
}

resource "aws_eip" "nat_single" {
  count = var.nat_per_az ? 0 : 1

  domain = "vpc"

  tags = {
    Name  = "${var.name_prefix}-nat-eip-single"
    Layer = "networking"
  }
}

resource "aws_nat_gateway" "single" {
  count = var.nat_per_az ? 0 : 1

  allocation_id = aws_eip.nat_single[0].id
  subnet_id     = aws_subnet.public[local.first_public_az].id

  tags = {
    Name  = "${var.name_prefix}-nat-single"
    Layer = "networking"
  }
}
