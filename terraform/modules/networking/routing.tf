resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id
}

# PUBLIC ROUTES
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
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

# PRIVATE ROUTES
resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = var.vpc_id
}

resource "aws_route" "private_nat" {
  for_each = aws_route_table.private

  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = (
    var.nat_per_az
    ? aws_nat_gateway.per_az[each.key].id
    : aws_nat_gateway.single[0].id
  )
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}
