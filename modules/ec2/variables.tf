# Images
variable "ec2_image_bastion" {}
variable "ec2_image_web" {}
variable "ec2_image_was" {}
variable "ec2_image_db" {}

# etc. property
variable "instance_type" {
    type = string
    default = "t2.micro"
}
variable "schedule_tag" {
    type = string
    default = "off-at-20"
}
variable "key_name" {}

# Subnet
variable "public_subnet_az1_id" {}
variable "private_web_subnet_az1_id" {}
variable "private_web_subnet_az2_id" {}
variable "private_was_subnet_az1_id" {}
variable "private_was_subnet_az2_id" {}
variable "private_data_subnet_az1_id" {}
variable "private_data_subnet_az2_id" {}

# Security group
variable "tf_sg_bastion_id" {}
variable "tf_sg_web_id" {}
variable "tf_sg_was_id" {}
variable "tf_sg_data_id" {}
variable "tf_sg_alb_web_id" {}

# ALB target group
variable "tf_atg_web_arn" {}