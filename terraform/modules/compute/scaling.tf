resource "aws_autoscaling_policy" "cpu_target" {
  count = var.target_cpu_utilization == null ? 0 : 1

  name                   = "${var.name_prefix}-cpu-scaling"
  autoscaling_group_name = aws_autoscaling_group.this.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.target_cpu_utilization
  }

  estimated_instance_warmup = 60
}
