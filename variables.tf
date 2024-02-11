# Key
variable "path_public_key" {}
variable "path_private_key" {}

# EC2 images
variable "ec2_image_bastion" {
  default = "ami-07eff2bc4837a9e01" # amazon2013
}

variable "ec2_image_web" {
  default = "ami-07eff2bc4837a9e01" # amazon2013
}

variable "ec2_image_was" {
  default = "ami-07eff2bc4837a9e01" # amazon2013
}

variable "ec2_image_db" {
  default = "ami-07eff2bc4837a9e01" # amazon2013
}

# for VPC
variable "region" {}
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_web_subnet_az1_cidr" {}
variable "private_web_subnet_az2_cidr" {}
variable "private_was_subnet_az1_cidr" {}
variable "private_was_subnet_az2_cidr" {}
variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}

