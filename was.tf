# WAS EC2
resource "aws_instance" "tf-ec2-pri-a-was1" {
  ami           = var.TOMCAT
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tf-sub-pri-a-was.id
  key_name      = aws_key_pair.tf-key.key_name
  vpc_security_group_ids = [
    aws_security_group.tf-sg-pri-was.id
  ]

  tags = {
    Name     = "tf-ec2-pri-a-was1"
    Schedule = "off-at-22"
  }
}

resource "aws_instance" "tf-ec2-pri-c-was2" {
  ami           = var.TOMCAT
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tf-sub-pri-c-was.id
  key_name      = aws_key_pair.tf-key.key_name
  vpc_security_group_ids = [
    aws_security_group.tf-sg-pri-was.id
  ]

  tags = {
    Name     = "tf-ec2-pri-c-was2"
    Schedule = "off-at-22"
  }
}