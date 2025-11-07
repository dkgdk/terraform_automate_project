terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "bucketfortfstatestorage" # or override via workflow
    key    = "ec2/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = var.aws_region
}

# Generate a key pair
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "github-actions-ec2-key"
  public_key = tls_private_key.example.public_key_openssh
}

# Save PEM file locally so GitHub Actions can upload it as artifact
resource "local_file" "private_key_pem" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/tf-key.pem"
}

# Create the EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-0dee22c13ea7a9a67" # Amazon Linux 2 AMI in ap-south-1
  instance_type = "t2.micro"
  key_name      = aws_key_pair.deployer_key.key_name

  tags = {
    Name = "GitHubActions-EC2"
  }
}
