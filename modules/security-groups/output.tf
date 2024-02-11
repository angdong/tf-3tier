output "tf_sg_bastion_id" {
    value = aws_security_group.tf-sg-pub-bastion.id
}

output "tf_sg_web_id" {
    value = aws_security_group.tf-sg-pri-web.id
}

output "tf_sg_was_id" {
    value = aws_security_group.tf-sg-pri-was.id
}

output "tf_sg_data_id" {
    value = aws_security_group.tf-sg-pri-db.id
}

output "tf_sg_alb_web_id" {
    value = aws_security_group.tf-sg-alb-web.id
}