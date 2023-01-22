# < Declare the region we are going to deploy our AWS resources >
provider "aws" {
  region = var.aws_region
}

# < Our S3 bucket >
resource "aws_s3_bucket" "terraform_state" {
    bucket = var.s3_name
    lifecycle {
      prevent_destroy = true
    }
}

resource "aws_s3_bucket_acl" "s3_acl" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

# < Encryption configuration for our S3 bucket >
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption_config" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

# < Enable versioning for our s3 bucket in case our bucket corrupts for some reason we can retrieve it back >
resource "aws_s3_bucket_versioning" "versioning_s3" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# < Our DynamoDB table with our state-locking configuration >
resource "aws_dynamodb_table" "terraform_statelock" {
    name = var.dynamodb_name
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
}