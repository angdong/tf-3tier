resource "aws_eip" "tf-nip" {
  domain = "vpc"
  tags = {
    Name = "tf-nip"
  }
}

resource "aws_nat_gateway" "tf-ngw" {
  allocation_id = aws_eip.tf-nip.id
  subnet_id     = aws_subnet.tf-sub-pub-a.id
  tags = {
    Name = "tf-ngw"
  }
}

# Route table for WEB
resource "aws_route_table" "tf-rt-pri-web" {
  vpc_id = aws_vpc.tf-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf-ngw.id
  }

  tags = {
    Name = "tf-rt-pri-web"
  }
}

resource "aws_route_table_association" "tf-rtass-pri-a-web" {
  subnet_id      = aws_subnet.tf-sub-pri-a-web.id
  route_table_id = aws_route_table.tf-rt-pri-web.id
}

resource "aws_route_table_association" "tf-rtass-pri-c-web" {
  subnet_id      = aws_subnet.tf-sub-pri-c-web.id
  route_table_id = aws_route_table.tf-rt-pri-web.id
}

# Route table for WAS
resource "aws_route_table" "tf-rt-pri-was" {
  vpc_id = aws_vpc.tf-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf-ngw.id
  }

  tags = {
    Name = "tf-rt-pri-was"
  }
}

resource "aws_route_table_association" "tf-rtass-pri-a-was" {
  subnet_id      = aws_subnet.tf-sub-pri-a-was.id
  route_table_id = aws_route_table.tf-rt-pri-was.id
}

resource "aws_route_table_association" "tf-rtass-pri-c-was" {
  subnet_id      = aws_subnet.tf-sub-pri-c-was.id
  route_table_id = aws_route_table.tf-rt-pri-was.id
}

# Route table for DB
resource "aws_route_table" "tf-rt-pri-db" {
  vpc_id = aws_vpc.tf-vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tf-ngw.id
  }

  tags = {
    Name = "tf-rt-pri-db"
  }
}

resource "aws_route_table_association" "tf-rtass-pri-a-db" {
  subnet_id      = aws_subnet.tf-sub-pri-a-db.id
  route_table_id = aws_route_table.tf-rt-pri-db.id
}

resource "aws_route_table_association" "tf-rtass-pri-c-db" {
  subnet_id      = aws_subnet.tf-sub-pri-c-db.id
  route_table_id = aws_route_table.tf-rt-pri-db.id
}