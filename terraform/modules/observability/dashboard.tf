resource "aws_cloudwatch_dashboard" "main" {
  count = var.enable_observability ? 1 : 0

  dashboard_name = "${var.name_prefix}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        properties = {
          title  = "ALB Latency"
          region = var.region

          metrics = [
            ["AWS/ApplicationELB", "TargetResponseTime", "LoadBalancer", var.alb_arn_suffix]
          ]

          period = 60
          stat   = "Average"
        }
      },
      {
        type = "metric",
        properties = {
          title  = "5xx Errors"
          region = var.region

          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_Target_5XX_Count", "TargetGroup", var.target_group_arn_suffix, "LoadBalancer", var.alb_arn_suffix]
          ]

          period = 60
          stat   = "Sum"
        }
      },
      {
        type = "metric",
        properties = {
          title  = "CPU Utilization"
          region = var.region

          metrics = [
            ["AWS/EC2", "CPUUtilization", "AutoScalingGroupName", var.asg_name]
          ]

          period = 60
          stat   = "Average"
        }
      }
    ]
  })
}
