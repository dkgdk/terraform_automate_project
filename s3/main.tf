provider "aws" {
  region = var.region
}

resource "random_id" "random_data" {
  byte_length = 8
}

resource "aws_s3_bucket" "bucket1" {
  bucket = "tf-s3-${random_id.random_data.hex}"
  force_destroy = true
}

resource "aws_s3_object" "data_s3" {
  bucket = aws_s3_bucket.bucket1.bucket
  source = var.local_file_path
  key    = var.object_key
}