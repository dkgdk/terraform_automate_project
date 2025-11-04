terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "random_id" "id" {
  byte_length = 6
}

resource "aws_s3_bucket" "tfstate_bucket" {
  bucket = "tfstate-${random_id.id.hex}"
  # acl    = "private"
  force_destroy = true
  tags = {
    Name = "terraform-tfstate-bucket"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.tfstate_bucket.bucket
}