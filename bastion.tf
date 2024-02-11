resource "aws_instance" "tf-ec2-pub-a-bastion" {
  ami           = var.AMI
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.tf-sub-pub-a.id
  key_name      = aws_key_pair.tf-key.key_name
  vpc_security_group_ids = [
    aws_security_group.tf-sg-pub-bastion.id
  ]

  # provisioner "file" {
  #   source      = var.PATH_TO_PRIVATE_KEY
  #   destination = "~/${var.PATH_TO_PRIVATE_KEY}"
  # }

  # connection {
  #   type = "ssh"
  #   user = "ec2-user"
  #   private_key = file(var.PATH_TO_PRIVATE_KEY)
  #   host = self.public_dns
  # }

  tags = {
    Name     = "tf-ec2-pub-a-bastion"
    Schedule = "off-at-22"
  }
}