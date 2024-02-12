# key path
path_public_key = "tf_test.pub"
path_private_key = "tf_test"

# AMI
ec2_image_bastion = "ami-07eff2bc4837a9e01"
ec2_image_web = "ami-0added3ada2ef6a48"
ec2_image_was = "ami-0f65fa787b1435660"
ec2_image_db = "ami-0a5a393cf47e6246d"

# region
region = "ap-northeast-2"

# VPC
vpc_cidr = "10.0.0.0/16"

public_subnet_az1_cidr = "10.0.0.0/24"
private_web_subnet_az1_cidr = "10.0.1.0/24"
private_was_subnet_az1_cidr = "10.0.2.0/24"
private_data_subnet_az1_cidr = "10.0.3.0/24"

public_subnet_az2_cidr = "10.0.10.0/24"
private_web_subnet_az2_cidr = "10.0.11.0/24"
private_was_subnet_az2_cidr = "10.0.12.0/24"
private_data_subnet_az2_cidr = "10.0.13.0/24"