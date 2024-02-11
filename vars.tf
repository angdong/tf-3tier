variable "PATH_TO_PUBLIC_KEY" {
  default = "tf_test.pub"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "tf_test"
}

# Have to specify in terraform.tfvars
variable "AMI" {
  default = "ami-07eff2bc4837a9e01" # amazon2013
}

variable "NGINX" {
  default = "ami-07eff2bc4837a9e01" # amazon2013
}

variable "TOMCAT" {
  default = "ami-07eff2bc4837a9e01" # amazon2013
}

variable "MONGODB" {
  default = "ami-07eff2bc4837a9e01" # amazon2013
}

variable "AWS_REGION" {}