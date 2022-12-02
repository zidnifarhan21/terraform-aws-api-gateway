resource "aws_autoscaling_group" "my-app" {
  name     = "my-app"
  min_size = 1
  max_size = 3
  # instance type
  health_check_type   = "EC2"
  vpc_zone_identifier = [aws_subnet.private-us-east-1a.id, aws_subnet.private-us-east-1b.id]
  target_group_arns   = [aws_lb_target_group.my-app.arn]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.my-app.id
      }
      override {
        instance_type     = "t3.small"
      }
    }
  }

}
# Kalo attach ke existing load balancer, maka otomatis ditambahin ke target group instance nya

resource "aws_autoscaling_policy" "my-app" {
  name                   = "my-app"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.my-app.name

  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 25.0
  }
}
