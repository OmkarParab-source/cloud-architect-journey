data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh.tpl")
}

resource "aws_launch_template" "this" {
  name_prefix   = "${var.name_prefix}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.ec2_security_group_id]

  iam_instance_profile {
    name = var.instance_profile_name
  }

  monitoring {
    enabled = true
  }

  user_data = base64encode(data.template_file.user_data.template)

  tags = {
    Name  = "${var.name_prefix}-lt"
    Layer = "compute"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name  = "${var.name_prefix}-ec2"
      Layer = "compute"
      Tier  = "private"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Name  = "${var.name_prefix}-volume"
      Layer = "compute"
    }
  }
}
