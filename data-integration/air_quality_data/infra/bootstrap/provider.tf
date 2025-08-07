terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.52.0"
    }
  }
  backend "s3" {
    bucket = "tf-air-quality-data-ingestion-bootstrap-state"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "tf-air-quality-data-ingestion-bootstrap-tflock"
    # workspace_key_prefix = "workspaces"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}
