resource "aws_launch_template" "web" {
  name_prefix   = "${local.name_prefix}-web-"
  image_id      = data.aws_ami.amazon_linux_2023.id
  instance_type = "t3.micro"

  vpc_security_group_ids = [var.web_sg_id]

  user_data = base64encode(templatefile("${path.root}/launch-script.tpl", {}))

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_ssm_profile.name
  }

  monitoring {
    enabled = true
  }

  tags = merge(var.common_tags, {
    Name      = "${local.name_prefix}-web-lt"
    Component = "web-launch-template"
    Tier      = "private"
  })

  tag_specifications {
    resource_type = "instance"
    tags          = local.instance_tags
  }

  tag_specifications {
    resource_type = "volume"
    tags          = local.instance_tags
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name = "${local.name_prefix}-web-asg"

  desired_capacity = 2
  min_size         = 2
  max_size         = 3

  vpc_zone_identifier = values(var.private_subnet_ids)

  target_group_arns = [var.target_group_arn]

  health_check_type         = "ELB"
  health_check_grace_period = 60

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage = 50
    }
  }

  dynamic "tag" {
    for_each = merge(var.common_tags, {
      Name      = "${local.name_prefix}-web-asg"
      Component = "web-autoscaling-group"
      Tier      = "private"
    })

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = false
    }
  }

  dynamic "tag" {
    for_each = local.instance_tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]
}
