# alb 생성
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