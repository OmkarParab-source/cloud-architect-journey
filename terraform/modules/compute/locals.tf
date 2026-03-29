locals {
  name_prefix = "${var.project}-${var.environment}"

  instance_tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-web"
    Component = "web-instance"
    Tier      = "private"
  })
}
