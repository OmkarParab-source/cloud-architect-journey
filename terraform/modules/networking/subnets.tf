resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = var.vpc_id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name  = "${var.name_prefix}-public-${each.key}"
    Layer = "networking"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name  = "${var.name_prefix}-private-${each.key}"
    Layer = "networking"
  }
}
