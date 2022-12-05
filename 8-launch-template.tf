resource "aws_launch_template" "my-app" {
  name     = "my-app"
  image_id = "ami-0982eb265f942054b" # your preconfigured image, AMI is region specific
  key_name = "mcf-ext-keypair"
  # instance_type di override di Scaling Group
  vpc_security_group_ids = [aws_security_group.my-app.id]

  private_dns_name_options {
    enable_resource_name_dns_a_record = true
  }
}