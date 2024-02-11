# VPC
resource "aws_vpc" "tf-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "tf-vpc"
  }
}

# Subnets
resource "aws_subnet" "tf-sub-pub-a" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}a"

  tags = {
    Name = "tf-sub-pub-a"
  }
}
resource "aws_subnet" "tf-sub-pri-a-web" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.AWS_REGION}a"

  tags = {
    Name = "tf-sub-pri-a-web"
  }
}
resource "aws_subnet" "tf-sub-pri-a-was" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.AWS_REGION}a"

  tags = {
    Name = "tf-sub-pri-a-was"
  }
}
resource "aws_subnet" "tf-sub-pri-a-db" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.AWS_REGION}a"

  tags = {
    Name = "tf-sub-pri-a-db"
  }
}

# ${var.AWS_REGION}c
resource "aws_subnet" "tf-sub-pub-c" {
  vpc_id                  = aws_vpc.tf-vpc.id
  cidr_block              = "10.0.10.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.AWS_REGION}c"

  tags = {
    Name = "tf-sub-pub-c"
  }
}
resource "aws_subnet" "tf-sub-pri-c-web" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "${var.AWS_REGION}c"

  tags = {
    Name = "tf-sub-pri-c-web"
  }
}
resource "aws_subnet" "tf-sub-pri-c-was" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "${var.AWS_REGION}c"

  tags = {
    Name = "tf-sub-pri-c-was"
  }
}
resource "aws_subnet" "tf-sub-pri-c-db" {
  vpc_id            = aws_vpc.tf-vpc.id
  cidr_block        = "10.0.13.0/24"
  availability_zone = "${var.AWS_REGION}c"

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