# VPC
resource "aws_vpc" "tf-vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "tf-vpc"
  }
}

# Subnets
resource "aws_subnet" "tf-sub-pub-a" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = var.public_subnet_az1_cidr
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.region}a"

  tags = {
    Name = "tf-sub-pub-a"
  }
}
resource "aws_subnet" "tf-sub-pri-a-web" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = var.private_web_subnet_az1_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "tf-sub-pri-a-web"
  }
}
resource "aws_subnet" "tf-sub-pri-a-was" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = var.private_was_subnet_az1_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "tf-sub-pri-a-was"
  }
}
resource "aws_subnet" "tf-sub-pri-a-db" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = var.private_data_subnet_az1_cidr
  availability_zone = "${var.region}a"

  tags = {
    Name = "tf-sub-pri-a-db"
  }
}

# ${var.region}c
resource "aws_subnet" "tf-sub-pub-c" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = var.public_subnet_az2_cidr
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.region}c"

  tags = {
    Name = "tf-sub-pub-c"
  }
}
resource "aws_subnet" "tf-sub-pri-c-web" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = var.private_web_subnet_az2_cidr
  availability_zone = "${var.region}c"

  tags = {
    Name = "tf-sub-pri-c-web"
  }
}
resource "aws_subnet" "tf-sub-pri-c-was" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = var.private_was_subnet_az2_cidr
  availability_zone = "${var.region}c"

  tags = {
    Name = "tf-sub-pri-c-was"
  }
}
resource "aws_subnet" "tf-sub-pri-c-db" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = var.private_was_subnet_az2_cidr
  availability_zone = "${var.region}c"

  tags = {
    Name = "tf-sub-pri-c-db"
  }
}

# Internet GW
resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = {
    Name = "tf-igw"
  }
}

# Route table
# public > igw
resource "aws_route_table" "tf-rt-pub" {
  vpc_id = aws_vpc.tf-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-igw.id
  }
  tags = {
    Name = "tf-rt-pub"
  }
}

# public subnet
resource "aws_route_table_association" "tf-rtass-pub-a" {
  subnet_id      = aws_subnet.tf-sub-pub-a.id
  route_table_id = aws_route_table.tf-rt-pub.id
}

resource "aws_route_table_association" "tf-rtass-pub-c" {
  subnet_id      = aws_subnet.tf-sub-pub-c.id
  route_table_id = aws_route_table.tf-rt-pub.id
}