terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "4.0.0"
      }
    }
  #backend "s3" {
   # bucket = "frankelybucket"
   # key = "global/s3/terraform.tfstate"
   # region = "us-east-1"
   # dynamodb_table = "frankelydynamo"
   # encrypt = true
  #}
}

