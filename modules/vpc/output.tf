output "region" {
    value = var.region
}

output "vpc_id" {
    value = aws_vpc.tf-vpc.id
}

output "public_subnet_az1_id" {
    value = aws_subnet.tf-sub-pub-a.id
    }
    
output "public_subnet_az2_id" {
    value = aws_subnet.tf-sub-pub-c.id
}

output "private_web_subnet_az1_id" {
    value = aws_subnet.tf-sub-pri-a-web.id
}

output "private_web_subnet_az2_id" {
    value = aws_subnet.tf-sub-pri-c-web.id
}

output "private_was_subnet_az1_id" {
    value = aws_subnet.tf-sub-pri-a-was.id
}

output "private_was_subnet_az2_id" {
    value = aws_subnet.tf-sub-pri-c-was.id
}
output "private_data_subnet_az1_id" {
    value = aws_subnet.tf-sub-pri-a-db.id
}

output "private_data_subnet_az2_id" {
    value = aws_subnet.tf-sub-pri-c-db.id
}

output "internet_gateway" {
    value = aws_internet_gateway.tf-igw
}