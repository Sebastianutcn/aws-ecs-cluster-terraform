# Create an EC2 launch template
resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "ecs-template"
  image_id      = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"

  key_name               = "ec2ecsglog"
  vpc_security_group_ids = [aws_security_group.security_group.id]
  iam_instance_profile {
    name = "ecsInstanceRole" #verificare
  }

  block_device_mappings {
    device_name = "/dev/xvda" #dev/sdf
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  # placement ? az

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ecs-instance"
    }
  }

  user_data = filebase64("${path.module}/ecs.sh") # se furnizeaza la lansarea instantei
}

# resource "aws_instance" "ecs_lt" {
#   ami           = "ami-0c101f26f147fa7fd"
#   instance_type = "t2.micro"
#   key_name      = "ec2ecsglog"

#   vpc_security_group_ids = [aws_security_group.security_group.id]
#   subnet_id = aws_subnet.subnet.id

#   associate_public_ip_address = true

#   user_data = filebase64("${path.module}/ecs.sh")

#   tags = {
#     Name = "ecs-instance"
#   }
# }

# Create an auto-scaling group (ASG)
resource "aws_autoscaling_group" "ecs_asg" {
  vpc_zone_identifier = [aws_subnet.subnet.id, aws_subnet.subnet2.id]
  desired_capacity    = 2
  max_size            = 3
  min_size            = 1

  launch_template {
    id      = aws_launch_template.ecs_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

# Configure ALB
resource "aws_lb" "ecs_alb" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  #vpc_id             = aws_vpc.main.id
  security_groups = [aws_security_group.security_group.id]
  subnets         = [aws_subnet.subnet.id, aws_subnet.subnet2.id]

  tags = {
    Name = "ecs-alb"
  }
}

resource "aws_lb_listener" "ecs_alb_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_tg.arn
  }
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = "ecs-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.main.id

  health_check {
    path = "/health"
    # interval = 30
    # timeout = 5
    # unhealthy_threshold = 2
    # healthy_threshold = 2
    # port = "80"
    # protocol = "HTTP"
    # matcher = "200"
  }
}

