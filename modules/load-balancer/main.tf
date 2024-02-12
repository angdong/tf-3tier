# ALB for web
resource "aws_alb" "tf-alb-web" {
  name               = "tf-alb-web"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.tf_sg_alb_web_id]
  subnets = [
    var.public_subnet_az1_id,
    var.public_subnet_az2_id
  ]
  tags = {
    Name = "tf-alb-web"
  }
}

# 타겟그룹 생성
resource "aws_alb_target_group" "tf-atg-web" {
  name        = "tf-atg-web"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  tags = {
    Name = "tf-atg-web"
  }
}

# 리스너 생성
resource "aws_alb_listener" "tf-alt-web" {
  load_balancer_arn = aws_alb.tf-alb-web.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tf-atg-web.arn
  }
}

# NLB for WAS
resource "aws_alb" "tf-nlb-was" {
  name               = "tf-nlb-was"
  internal           = false
  load_balancer_type = "network"
  subnets            = [
    var.private_web_subnet_az1_id,
    var.private_web_subnet_az2_id
  ] # web subnet에서 was를 바라봄
  tags = {
    Name = "tf-nlb-was"
  }
}

# 타겟그룹 생성
resource "aws_alb_target_group" "tf-atg-was" {
  name        = "tf-atg-was"
  port        = "8080"
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "instance"
  tags = {
    Name = "tf-atg-was"
  }
}

# 리스너 생성
resource "aws_alb_listener" "tf-alt-was" {
  load_balancer_arn = aws_alb.tf-nlb-was.arn
  port              = "8080"
  protocol          = "TCP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tf-atg-was.arn
  }
}