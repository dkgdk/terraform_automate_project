terraform {
  backend "s3" {
    bucket = "bucketfortfstatestorage"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
