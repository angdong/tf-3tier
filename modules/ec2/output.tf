output "atg_web_name" {
    value = aws_autoscaling_group.tf-ec2-asg-web.name
}

output "tf_ec2_was1_id" {
    value = aws_instance.tf-ec2-pri-a-was1.id
}

output "tf_ec2_was2_id" {
    value = aws_instance.tf-ec2-pri-c-was2.id
}