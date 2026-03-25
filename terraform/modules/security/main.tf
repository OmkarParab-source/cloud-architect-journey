resource "aws_security_group" "alb" {
  name        = "alb-sg"
  description = "Allow HTTP from Internet"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "alb-sg"
  })
}

resource "aws_security_group_rule" "alb_inbound_http" {
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
  name        = "ec2-sg"
  description = "Allow traffic only from ALB"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "ec2-sg"
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
