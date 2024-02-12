output "tf_atg_web_arn" {
    value = aws_alb_target_group.tf-atg-web.arn
}

output "tf_atg_was_arn" {
    value = aws_alb_target_group.tf-atg-was.arn
}