provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "magnusvpc" {
   cidr_block = "10.0.0.0/24"

  tags = {
    Name = "Class30"
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
    bucket = "class-magnus-amudi"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

