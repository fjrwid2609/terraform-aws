resource "aws_launch_configuration" "template" {
  name          = "template"
  image_id      = var.image_id
  instance_type = "t2.medium"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                      = "asg"
  max_size                  = 5
  min_size                  = 2
  desired_capacity          = 2
  launch_configuration      = aws_launch_configuration.template.name
  vpc_zone_identifier       = [aws_subnet.private.id]
}

resource "aws_autoscaling_policy" "asg" {
  name                   = "asg-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

resource "aws_cloudwatch_metric_alarm" "asg" {
  alarm_name          = "asg-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "45"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.asg.arn]
}