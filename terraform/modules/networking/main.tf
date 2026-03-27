resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = local.az_map[each.value.az_key]
  map_public_ip_on_launch = true

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-${each.key}"
    Component = "public-subnet"
    Tier      = "public"
  })
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = local.az_map[each.value.az_key]

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-${each.key}"
    Component = "private-subnet"
    Tier      = "private"
  })
}

resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-igw"
    Component = "internet-gateway"
  })
}

resource "aws_eip" "nat" {
  for_each = local.az_map

  domain = "vpc"

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-eip-${each.key}"
    Component = "elastic-ip"
  })
}

resource "aws_nat_gateway" "this" {
  for_each = local.az_map

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = aws_subnet.public[local.public_subnet_by_az[each.key]].id

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-nat-${each.key}"
    Component = "nat-gateway"
  })

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-public-rt"
    Component = "route-table"
  })
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  for_each = local.az_map

  vpc_id = var.vpc_id

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-private-rt-${each.key}"
    Component = "route-table"
  })
}

resource "aws_route" "private_nat" {
  for_each = local.az_map

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[each.key].id
}

resource "aws_route_table_association" "private" {
  for_each = var.private_subnets

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.value.az_key].id
}
