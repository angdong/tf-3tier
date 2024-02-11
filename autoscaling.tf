resource "aws_launch_configuration" "tf-ec2-config-web" {
  name          = "tf-ec2-asg-web"
  image_id      = var.NGINX
  instance_type = "t2.micro"
  key_name = aws_key_pair.tf-key.key_name
  security_groups = [aws_security_group.tf-sg-pri-web.id]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "tf-ec2-asg-web" {
  name                      = "tf-ec2-asg-web"
  vpc_zone_identifier       = [aws_subnet.tf-sub-pri-a-web.id, aws_subnet.tf-sub-pri-c-web.id]
  launch_configuration      = aws_launch_configuration.tf-ec2-config-web.name
  min_size                  = 2
  max_size                  = 4
  health_check_grace_period = 300
  health_check_type         = "EC2"
  target_group_arns = [aws_alb_target_group.tf-atg-web.arn]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "tf-ec2-asg-web"
    propagate_at_launch = true
  }

  tag {
    key = "Schedule"
    value = "off-at-22"
    propagate_at_launch = true
  }
}