resource "aws_cloudwatch_metric_alarm" "asg_cpu_utilization" {
  alarm_name        = "${local.name_prefix}-cpu-utilization-alarm"
  alarm_description = "High CPU utilization alarm for Auto Scaling Group"

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web_asg.name
  }
  statistic           = "Average"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = "70"
  period              = "60"
  evaluation_periods  = "2"

  treat_missing_data = "notBreaching"

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-cpu-utilization-alarm"
    Component = "compute-monitoring"
  })
}
