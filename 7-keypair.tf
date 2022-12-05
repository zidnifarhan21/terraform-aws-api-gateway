resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "mcf-ext-keypair"
  public_key = tls_private_key.pk.public_key_openssh # Generate Public Key and store on aws
}

resource "local_file" "key" {
  content = tls_private_key.pk.private_key_pem # Generate Private Key and store on local
  filename = "mcf-ext-keypair"
}