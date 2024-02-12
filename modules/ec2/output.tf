output "atg_web_name" {
    value = aws_autoscaling_group.tf-ec2-asg-web.name
}

output "atg_was_name" {
    value = aws_autoscaling_group.tf-ec2-asg-was.name
}