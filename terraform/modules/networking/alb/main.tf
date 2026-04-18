resource "aws_lb" "this" {
  name               = "${var.name_prefix}-alb"
  load_balancer_type = "application"
  subnets            = var.subnets
}
