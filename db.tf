# DB EC2
resource "aws_instance" "tf-ec2-pri-a-db1" {
  ami           = var.MONGODB
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tf-sub-pri-a-db.id
  key_name      = aws_key_pair.tf-key.key_name
  vpc_security_group_ids = [
    aws_security_group.tf-sg-pri-db.id
  ]

  tags = {
    Name     = "tf-ec2-pri-a-db1"
    Schedule = "off-at-22"
  }
}

resource "aws_instance" "tf-ec2-pri-c-db2" {
  ami           = var.MONGODB
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tf-sub-pri-c-db.id
  key_name      = aws_key_pair.tf-key.key_name
  vpc_security_group_ids = [
    aws_security_group.tf-sg-pri-db.id
  ]

  tags = {
    Name     = "tf-ec2-pri-c-db2"
    Schedule = "off-at-22"
  }
}

resource "aws_instance" "tf-ec2-pri-c-db3" {
  ami           = var.MONGODB
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tf-sub-pri-c-db.id
  key_name      = aws_key_pair.tf-key.key_name
  vpc_security_group_ids = [
    aws_security_group.tf-sg-pri-db.id
  ]

  tags = {
    Name     = "tf-ec2-pri-c-db3"
    Schedule = "off-at-22"
  }
}