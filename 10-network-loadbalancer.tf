resource "aws_lb_target_group" "my-app" {
  name     = "my-app"
  port     = 8080
  protocol = "TCP" # Protocol perlu TCP agar bisa terhubung ke Listener di Network Load Balancer
  vpc_id   = aws_vpc.main.id

  health_check {
    enabled  = true
    protocol = "HTTP" # sesuaikan dengan app
    port     = 8080
    path     = "/health"
    matcher  = "200-299"
  }
}


resource "aws_lb" "my-app" {
  name               = "my-app"
  internal           = true
  load_balancer_type = "network" # only NLB supported for REST API Gateway

  subnets = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id
  ]
}

resource "aws_lb_listener" "my-app" {
  load_balancer_arn = aws_lb.my-app.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-app.arn
  }
}
# Listener LB di 80 aja, biar default port http, target group baru arahin ke port aplikasi