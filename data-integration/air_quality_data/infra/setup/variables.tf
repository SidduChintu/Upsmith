# AWS Region
variable "aws_region" {
  type = string
  description = "The AWS region"
  default = "us-east-1"
}

# Bootstrap TFState Bucket
variable "bootstrap_tfstate_bucket_name" {
  type = string
  description = "The name of the bootstrap tfstate bucket"
  default = "tf-air-quality-data-ingestion-bootstrap-state"
}

# Infra TFState Bucket
variable "infra_tfstate_bucket_name" {
  type = string
  description = "The name of the infra tfstate bucket"
  default = "tf-air-quality-data-ingestion-infra-state"
}

# Bootstrap TFLock DynamoDB Table
variable "bootstrap_tflock_dynamodb_table_name" {
  type = string
  description = "The name of the bootstrap tflock dynamodb table"
  default = "tf-air-quality-data-ingestion-bootstrap-tflock"
}

# Infra TFLock DynamoDB Table
variable "infra_tflock_dynamodb_table_name" {
  type = string
  description = "The name of the infra tflock dynamodb table"
  default = "tf-air-quality-data-ingestion-infra-tflock"
}

