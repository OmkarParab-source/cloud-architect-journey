resource "aws_cloudwatch_metric_alarm" "unhealthy_hosts" {
  alarm_name        = "${local.name_prefix}-unhealthy-hosts"
  alarm_description = "Alarm when the number of unhealthy hosts in the target group is greater than 0"

  metric_name = "UnhealthyHostCount"
  namespace   = "AWS/ApplicationELB"
  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }
  statistic           = "Average"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = "1"
  period              = "60"
  evaluation_periods  = "1"

  treat_missing_data = "notBreaching"

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-unhealthy-hosts"
    Component = "alb-monitoring"
  })
}
