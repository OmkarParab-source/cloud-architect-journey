resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = merge(var.tags, {
    Name = var.vpc_name
  })
}

resource "aws_subnet" "public" {
  for_each = {
    for subnet in var.public_subnets :
    subnet.name => subnet
  }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = local.az_map[each.value.az_key]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = each.value.name
    Tier = "public"
  })
}

resource "aws_subnet" "private" {
  for_each = {
    for subnet in var.private_subnets :
    subnet.name => subnet
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = local.az_map[each.value.az_key]

  tags = merge(var.tags, {
    Name = each.value.name
    Tier = "private"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-igw"
  })
}
