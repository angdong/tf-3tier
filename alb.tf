# alb 생성
resource "aws_alb" "tf-alb-web" {
  name               = "tf-alb-web"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tf-sg-alb-web.id]
  subnets = [
    aws_subnet.tf-sub-pub-a.id,
    aws_subnet.tf-sub-pub-c.id
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
  vpc_id      = aws_vpc.tf-vpc.id
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

# # instance web attachment
# resource "aws_lb_target_group_attachment" "tf-att-web1" {
#   target_group_arn = aws_lb_target_group.tf-atg-web.arn
#   target_id        = aws_instance.tf-ec2-pri-a-web1.id
#   port             = 80
# }
# resource "aws_lb_target_group_attachment" "tf-att-web2" {
#   target_group_arn = aws_lb_target_group.tf-atg-web.arn
#   target_id        = aws_instance.tf-ec2-pri-c-web2.id
#   port             = 80
# }

# alb sg
resource "aws_security_group" "tf-sg-alb-web" {
  name        = "tf-sg-alb-web"
  description = "tf-sg-alb-web"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "tf-sg-alb-web"
  }
}