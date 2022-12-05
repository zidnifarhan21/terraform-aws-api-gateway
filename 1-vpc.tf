resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main"
  }
}


# VPC Endpoint for API Gateway
resource "aws_vpc_endpoint" "my-app" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.execute-api" # region

  security_group_ids = [
    aws_security_group.my-app-endpoint.id,
  ]

  subnet_ids = [
    aws_subnet.private-us-east-1a.id,
    aws_subnet.private-us-east-1b.id
  ]

  private_dns_enabled = true
}
