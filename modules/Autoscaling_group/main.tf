data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "laptop_lt" {
  name_prefix            = "${var.name_prefix}-laptop-lt"
  image_id               = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.ec2_security_group_id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Laptop Service</h1> </br> $(hostname)" > /var/www/html/index.html
              EOF
  )

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-laptop-lt"
  })
}

resource "aws_launch_template" "mobile_lt" {
  name_prefix   = "${var.name_prefix}-mobile-lt"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.ec2_security_group_id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Mobile Service</h1>" > /var/www/html/index.html
              EOF
  )

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-mobile-lt"
  })
}

resource "aws_launch_template" "home_lt" {
  name_prefix   = "${var.name_prefix}-home-lt"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.ec2_security_group_id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Home Service</h1>" > /var/www/html/index.html
              EOF
  )

  tags = merge(var.tags, {
    Name = "${var.name_prefix}-home-lt"
  })
}

resource "aws_autoscaling_group" "laptop_asg" {
  name                = "${var.name_prefix}-laptop-asg"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.laptop_lt.id
    version = "$Latest"
  }

  target_group_arns = [var.laptop_target_group_arn]

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-laptop-instance"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_group" "mobile_asg" {
  name                = "${var.name_prefix}-mobile-asg"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.mobile_lt.id
    version = "$Latest"
  }

  target_group_arns = [var.mobile_target_group_arn]

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-mobile-instance"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_group" "home_asg" {
  name                = "${var.name_prefix}-home-asg"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.home_lt.id
    version = "$Latest"
  }

  target_group_arns = [var.home_target_group_arn]

  tag {
    key                 = "Name"
    value               = "${var.name_prefix}-home-instance"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}