resource "aws_security_group" "alb" {
  name        = "${local.name_prefix}-alb-sg"
  description = "ALB security group"
  vpc_id      = var.vpc_id

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-alb-sg"
    Component = "alb-sg"
    Tier      = "public"
  })
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443

  cidr_ipv4 = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "alb_outbound" {
  security_group_id = aws_security_group.alb.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_security_group" "web" {
  name        = "${local.name_prefix}-web-sg"
  description = "Web tier security group"
  vpc_id      = var.vpc_id

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-web-sg"
    Component = "web-sg"
    Tier      = "private"
  })
}

resource "aws_vpc_security_group_ingress_rule" "web_from_alb" {
  security_group_id = aws_security_group.web.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80

  referenced_security_group_id = aws_security_group.alb.id
}

resource "aws_vpc_security_group_egress_rule" "web_outbound" {
  security_group_id = aws_security_group.web.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
