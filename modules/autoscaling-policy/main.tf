# scale out alarm
resource "aws_autoscaling_policy" "tf-cpu-policy-scale-out" {
  name                   = "tf-cpu-policy-scale-out"
  autoscaling_group_name = var.atg_web_name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1" # Scale-out
  cooldown               = "60"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "tf-cpu-alarm-scale-out" {
  alarm_name          = "tf-cpu-alarm-scale-out"
  alarm_description   = "tf-cpu-alarm-scale-out"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "40"

  dimensions = {
    "AutoScalingGroupName" = var.atg_web_name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.tf-cpu-policy-scale-out.arn]
}

# scale in alarm
resource "aws_autoscaling_policy" "tf-cpu-policy-scale-in" {
  name                   = "tf-cpu-policy-scaledown"
  autoscaling_group_name = var.atg_web_name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "tf-cpu-alarm-scale-in" {
  alarm_name          = "tf-cpu-alarm-scale-in"
  alarm_description   = "tf-cpu-alarm-scale-in"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = var.atg_web_name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.tf-cpu-policy-scale-in.arn]
}

# predictive scale
resource "aws_autoscaling_policy" "tf-cpu-policy-pred" {
  name                   = "tf-cpu-policy-pred"
  policy_type = "PredictiveScaling"
  autoscaling_group_name = var.atg_web_name
  predictive_scaling_configuration {
    metric_specification {
      target_value = 32
      predefined_scaling_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
        resource_label         = "testLabel"
      }
      predefined_load_metric_specification {
        predefined_metric_type = "ASGTotalCPUUtilization"
        resource_label         = "testLabel"
      }
    }
    mode                          = "ForecastAndScale"
    scheduling_buffer_time        = 10
    max_capacity_breach_behavior  = "IncreaseMaxCapacity"
    max_capacity_buffer           = 10
  }
}