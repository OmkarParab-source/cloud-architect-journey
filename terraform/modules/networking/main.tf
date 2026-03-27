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
  domain = "vpc"

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-eip"
    Component = "elastic-ip"
  })
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id

  # Currently hardcoded Single NAT for Learning purpose
  # TODO: Per-AZ NAT later during production hardening
  subnet_id = aws_subnet.public["public-subnet-1"].id

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-nat"
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
  vpc_id = var.vpc_id

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-private-rt"
    Component = "route-table"
  })
}

resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = aws_nat_gateway.this.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
