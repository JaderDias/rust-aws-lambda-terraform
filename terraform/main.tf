terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.34.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "random_pet" "one" {
  length = 1
}

resource "random_pet" "two" {
  length = 1
}

module "edit_function" {
  source = "./modules/function"

  bucket_name         = aws_s3_bucket.bucket.id
  dynamodb_table_name = aws_dynamodb_table.site_table.name
  function_name       = "${terraform.workspace}_render_${random_pet.one.id}_${random_pet.two.id}"
  lambda_handler      = "handler"
  source_dir          = "../bin/render"
  tags = {
    environment = terraform.workspace
  }
}
