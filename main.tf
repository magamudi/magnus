provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "newvpc" {
   cidr_block = "10.0.0.0/24"

  tags = {
    Name = "trial"
    Team = "DevOps"
    Environment = "Prod"
    Division = "HR"
  }
}

terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0" # Optional but recommended in production
    }
  }
  backend "s3" {
    bucket = "aws_s3_bucket.onebucket.id"
    key = "new/terraform.tfstate"
    region = "us-east-1"
  }
}

resource "aws_s3_bucket" "onebucket" {
   bucket = "var.bucket"
   acl = "private"
   versioning {
      enabled = true
   }
   tags = {
     Name = "newbucket"
     Environment = "Test"
   }
}

resource "random_string" "random_suffix" {
  length  = 3
  special = false
  upper   = false
}

variable "bucket" {
  type = string
  description = "this is the name of my s3 bucket"
  default = "s3-bucket-${random_string.random_suffix.result}"
}

