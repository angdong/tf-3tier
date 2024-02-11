# scale up alarm
resource "aws_autoscaling_policy" "tf-cpu-policy" {
  name                   = "tf-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.tf-ec2-asg-web.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1" # Scale-out
  cooldown               = "60"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm" {
  alarm_name          = "tf-cpu-alarm"
  alarm_description   = "tf-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "40"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.tf-ec2-asg-web.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.tf-cpu-policy.arn]
}

# scale down alarm
resource "aws_autoscaling_policy" "tf-cpu-policy-scaledown" {
  name                   = "tf-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.tf-ec2-asg-web.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "tf-cpu-alarm-scaledown" {
  alarm_name          = "tf-cpu-alarm-scaledown"
  alarm_description   = "tf-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.tf-ec2-asg-web.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.tf-cpu-policy-scaledown.arn]
}