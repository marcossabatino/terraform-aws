provider "aws" {
  region = "us-east-2"
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.15.1"
}

resource "aws_s3_bucket" "bucket-s3-base" {
  bucket = "bucket-s3-base"
}

#resource "aws_s3_bucket_acl" "bucket-s3-base" {
#  bucket = aws_s3_bucket.bucket-s3-base.id
#  acl    = "private"
#}

resource "aws_s3_bucket_versioning" "versioning_bucket_s3_base" {
  bucket = aws_s3_bucket.bucket-s3-base.id
  versioning_configuration {
    status = "Enabled"
  }
}
