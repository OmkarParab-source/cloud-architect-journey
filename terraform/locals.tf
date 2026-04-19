locals {
  name_prefix = "${var.service}-${var.environment}"

  global_tags = {
    Service     = var.service
    Environment = var.environment
    Owner       = var.owner
    ManagedBy   = "terraform"
  }

  # derived behavior
  scaling_enabled = var.target_cpu_utilization != null
  multi_az        = length(var.private_subnets) > 1
}
