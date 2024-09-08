terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.65.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
  }
}
provider "aws" {
  region = "us-east-1"

}
resource "random_id" "ran_id" {
  byte_length = 8
}
resource "aws_s3_bucket" "demo" {
    bucket = "bucket-${random_id.ran_id.hex}"
}
resource "aws_s3_object" "bucket_data" {
  bucket = aws_s3_bucket.demo.bucket
  source = "./terraform.tfstate"
  key = "statefile_backup.tfstate"
}
