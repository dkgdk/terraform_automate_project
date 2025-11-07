variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}
variable "instance_type" { 
    type = string 
    default = "t2.micro" 
    }
variable "ami_id" { 
    type = string 
    default = "ami-00bb6a80f01f03502" 
    }
variable "instance_name" { 
    type = string 
    default = "ubuntu1" 
    }

variable "aws_region" {
  description = "AWS region to deploy EC2 instance"
  default     = "ap-south-1"
}
