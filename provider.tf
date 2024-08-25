terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.58.0"
    }
  }

  backend "s3" {
    bucket = "daws-76-bhargav-tfstate"
    key    = "provisioners"
    region = "us-east-1"
    dynamodb_table = "daws-tfstate-table"
  }

}

provider "aws" {
    region = "us-east-1"
}