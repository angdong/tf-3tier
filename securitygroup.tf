resource "aws_security_group" "tf-sg-pub-bastion" {
  name        = "tf-sg-pub-bastion"
  description = "tf-sg-pub-bastion"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
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
    Name = "tf-sg-pub-bastion"
  }
}

# Web SG
resource "aws_security_group" "tf-sg-pri-web" {
  name        = "tf-sg-pri-web"
  description = "tf-sg-pri-web"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.tf-sg-pub-bastion.id]
  }

  # Http any open
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
    Name = "tf-sg-pri-web"
  }
}

# Was SG
resource "aws_security_group" "tf-sg-pri-was" {
  name        = "tf-sg-pri-was"
  description = "tf-sg-pri-was"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.tf-sg-pub-bastion.id]
  }

  # Http any open
  ingress {
    from_port   = 8080
    to_port     = 8080
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
    Name = "tf-sg-pri-was"
  }
}

# DB SG
resource "aws_security_group" "tf-sg-pri-db" {
  name        = "tf-sg-pri-db"
  description = "tf-sg-pri-db"
  vpc_id      = aws_vpc.tf-vpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.tf-sg-pub-bastion.id]
  }

  # Http any open
  ingress {
    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"
    # mongodb PSS 위해 27017 오픈
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-sg-pri-db"
  }
}