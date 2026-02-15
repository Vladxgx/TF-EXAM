# Scaling resources

data "aws_ami" "ubuntu_2204" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["*22.04*"]
  }
}

resource "aws_launch_template" "app_lt" {
  name_prefix   = "${var.name_prefix}-app-lt-"
  image_id      = data.aws_ami.ubuntu_2204.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.app_instance_sg.id]

  user_data = base64encode(<<-EOF
#!/bin/bash
apt-get update -y
apt-get install -y apache2
echo "ok" > /var/www/html/index.html
systemctl enable --now apache2
EOF
  )
}

resource "aws_autoscaling_group" "app_asg" {
  name = "${var.name_prefix}-app-asg"

  max_size         = 3
  min_size         = 1
  desired_capacity = 1

  vpc_zone_identifier = module.vpc.public_subnet_ids

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.app_tg.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 60
}

resource "aws_security_group" "app_instance_sg" {
  name        = "${var.name_prefix}-app-instance-sg"
  description = "allow only http from ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}