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

resource "aws_security_group_rule" "alb_http" {
  type              = "ingress"
  security_group_id = aws_security_group.alb.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.alb.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group" "ec2" {
  name        = "${local.name_prefix}-ec2-sg"
  description = "Allow traffic only from ALB"
  vpc_id      = var.vpc_id

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-ec2-sg"
    Component = "ec2-sg"
    Tier      = "private"
  })
}

resource "aws_security_group_rule" "ec2_inbound_from_alb" {
  type              = "ingress"
  security_group_id = aws_security_group.ec2.id

  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  source_security_group_id = aws_security_group.alb.id
}

resource "aws_security_group_rule" "ec2_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.ec2.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
