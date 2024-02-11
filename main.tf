# VPC
module "vpc" {
    source = "./modules/vpc"
    region = var.region
    vpc_cidr = var.vpc_cidr
    public_subnet_az1_cidr = var.public_subnet_az1_cidr
    public_subnet_az2_cidr = var.public_subnet_az2_cidr
    private_web_subnet_az1_cidr = var.private_web_subnet_az1_cidr
    private_web_subnet_az2_cidr = var.private_web_subnet_az2_cidr
    private_was_subnet_az1_cidr = var.private_was_subnet_az1_cidr
    private_was_subnet_az2_cidr = var.private_was_subnet_az2_cidr
    private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
    private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}

# security groups
module "security-groups" {
    source = "./modules/security-groups"
    vpc_id = module.vpc.vpc_id
}

# key
module "key" {
    source = "./modules/key"
    path_public_key = var.path_public_key
}

# nat-gateway
module "nat-gateway" {
    source = "./modules/nat_gateway"
    vpc_id                         = module.vpc.vpc_id
    public_subnet_az1_id = module.vpc.public_subnet_az1_id
    private_web_subnet_az1_id      = module.vpc.private_web_subnet_az1_id
    private_web_subnet_az2_id      = module.vpc.private_web_subnet_az2_id
    private_was_subnet_az1_id      = module.vpc.private_was_subnet_az1_id
    private_was_subnet_az2_id     = module.vpc.private_was_subnet_az2_id
    private_data_subnet_az1_id     = module.vpc.private_data_subnet_az1_id
    private_data_subnet_az2_id     = module.vpc.private_data_subnet_az2_id
}

# load-balancer
module "load-balancer" {
    source = "./modules/load-balancer"
    vpc_id =module.vpc.vpc_id
    tf_sg_alb_web_id = module.security-groups.tf_sg_alb_web_id
    public_subnet_az1_id = module.vpc.public_subnet_az1_id
    public_subnet_az2_id = module.vpc.public_subnet_az2_id
    private_web_subnet_az1_id = module.vpc.private_was_subnet_az1_id
    private_web_subnet_az2_id = module.vpc.private_was_subnet_az2_id
    tf_ec2_was1_id = module.ec2.tf_ec2_was1_id
    tf_ec2_was2_id = module.ec2.tf_ec2_was2_id
}

# EC2
module "ec2" {
    source = "./modules/ec2"
    ec2_image_bastion = var.ec2_image_bastion
    ec2_image_web = var.ec2_image_web
    ec2_image_was = var.ec2_image_was
    ec2_image_db = var.ec2_image_db
    key_name = module.key.key_name

    public_subnet_az1_id = module.vpc.public_subnet_az1_id
    private_web_subnet_az1_id = module.vpc.private_web_subnet_az1_id
    private_web_subnet_az2_id = module.vpc.private_web_subnet_az2_id
    private_was_subnet_az1_id = module.vpc.private_was_subnet_az1_id
    private_was_subnet_az2_id = module.vpc.private_was_subnet_az2_id
    private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
    private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id

    tf_sg_bastion_id = module.security-groups.tf_sg_bastion_id
    tf_sg_web_id = module.security-groups.tf_sg_web_id
    tf_sg_was_id = module.security-groups.tf_sg_was_id
    tf_sg_data_id = module.security-groups.tf_sg_data_id
    tf_sg_alb_web_id = module.security-groups.tf_sg_alb_web_id

    tf_atg_web_arn = module.load-balancer.tf_atg_web_arn
}

# ASG policy
module "autoscaling-policy" {
    source = "./modules/autoscaling-policy"
    atg_web_name = module.ec2.atg_web_name
}