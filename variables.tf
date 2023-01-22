variable "aws_region" {
    type = string
    default = "us-east-1"
    description = "Region to deploy our resources"
}

variable "s3_name" {
    type = string
    default = "frankelybucket"
    description = "Name of our S3 bucket"
}

variable "dynamodb_name" {
    type = string
    default = "frankelydynamo"
    description = "Name of our S3 bucket"
}
