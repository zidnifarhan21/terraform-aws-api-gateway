resource "aws_security_group" "my-app" {
  name        = "my-app"
  description = "Allow API Access"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow Health Checks"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  # mandatory, eggress trafic for terraform, -1 == all protocol
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "my-app-endpoint" {
  name        = "my-app-endpoint"
  description = "Allow HTTP Traffic from private subnet"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private-us-east-1a.cidr_block, aws_subnet.private-us-east-1b.cidr_block]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private-us-east-1a.cidr_block, aws_subnet.private-us-east-1b.cidr_block]
  }

  ingress {
    description = "Allow ICMP"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [aws_subnet.private-us-east-1a.cidr_block, aws_subnet.private-us-east-1b.cidr_block]
  }

  # mandatory, eggress trafic for terraform, -1 == all protocol
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}