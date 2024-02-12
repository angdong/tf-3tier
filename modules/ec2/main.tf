# bastion EC2
resource "aws_instance" "tf-ec2-pub-a-bastion" {
  ami           = var.ec2_image_bastion
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_az1_id
  key_name      = var.key_name
  vpc_security_group_ids = [
    var.tf_sg_bastion_id
  ]

  tags = {
    Name     = "tf-ec2-pub-a-bastion"
    Schedule = var.schedule_tag
  }
}

# autoscaling web EC2
resource "aws_launch_configuration" "tf-ec2-config-web" {
  name_prefix          = "tf-ec2-asg-web"
  image_id      = var.ec2_image_web
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = [
    var.tf_sg_web_id
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "tf-ec2-asg-web" {
  name                      = "tf-ec2-asg-web"
  vpc_zone_identifier       = [
    var.private_web_subnet_az1_id,
    var.private_web_subnet_az2_id
  ]
  launch_configuration      = aws_launch_configuration.tf-ec2-config-web.name
  min_size                  = 2
  max_size                  = 4
  health_check_grace_period = 300
  health_check_type         = "EC2"
  target_group_arns = [
    var.tf_atg_web_arn
  ]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "tf-ec2-asg-web"
    propagate_at_launch = true
  }

  tag {
    key = "Schedule"
    value = var.schedule_tag
    propagate_at_launch = true
  }
}

# autoscaling was EC2
resource "aws_launch_configuration" "tf-ec2-config-was" {
  name_prefix          = "tf-ec2-asg-was"
  image_id      = var.ec2_image_was
  instance_type = var.instance_type
  security_groups = [
    var.tf_sg_was_id
  ]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "tf-ec2-asg-was" {
  name                      = "tf-ec2-asg-was"
  vpc_zone_identifier = [
    var.private_was_subnet_az1_id,
    var.private_was_subnet_az2_id
  ]
  launch_configuration = aws_launch_configuration.tf-ec2-config-was.name
  min_size                  = 2
  max_size                  = 4
  health_check_grace_period = 300
  health_check_type         = "EC2"
  target_group_arns = [
    var.tf_atg_was_arn
  ]
  force_delete = true

  tag {
    key                 = "Name"
    value               = "tf-ec2-asg-was"
    propagate_at_launch = true
  }

  tag {
    key                 = "Schedule"
    value               = var.schedule_tag
    propagate_at_launch = true
  }
}

# DB EC2
resource "aws_instance" "tf-ec2-pri-a-db1" {
  ami           = var.ec2_image_db
  instance_type = var.instance_type
  subnet_id     = var.private_data_subnet_az1_id
  key_name      = var.key_name
  vpc_security_group_ids = [
    var.tf_sg_data_id
  ]

  tags = {
    Name     = "tf-ec2-pri-a-db1"
    Schedule = var.schedule_tag
  }
}

resource "aws_instance" "tf-ec2-pri-c-db2" {
  ami           = var.ec2_image_db
  instance_type = var.instance_type
  subnet_id     = var.private_data_subnet_az2_id
  key_name      = var.key_name
  vpc_security_group_ids = [
    var.tf_sg_data_id
  ]

  tags = {
    Name     = "tf-ec2-pri-c-db2"
    Schedule = var.schedule_tag
  }
}

resource "aws_instance" "tf-ec2-pri-c-db3" {
  ami           = var.ec2_image_db
  instance_type = var.instance_type
  subnet_id     = var.private_data_subnet_az2_id
  key_name      = var.key_name
  vpc_security_group_ids = [
    var.tf_sg_data_id
  ]

  tags = {
    Name     = "tf-ec2-pri-c-db3"
    Schedule = var.schedule_tag
  }
}