provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.23.0"
    }
  }

  required_version = "~> 1.0"
}

# Note
# Something that need to predefined manually
# 1. Create IAM Access Key
# 2. Create Keypair
# 3. Create Image AMI