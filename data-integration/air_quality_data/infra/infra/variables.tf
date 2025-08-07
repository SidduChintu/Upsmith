# Environment
variable "env" {
  type = string
  description = "The environment to deploy"
}

# Project Name
variable "project_name" {
  type = string
  description = "The name of the project"
  default = "Air Quality Data Ingestion"
}

# AWS Region
variable "aws_region" {
  type = string
  description = "The AWS region"
}

# AWS Account ID
variable "aws_account_id" {
  type = string
  description = "The AWS account ID"
}

# VPC ID
variable "vpc_id" {
  type = string
  description = "The VPC ID"
}

# Private Subnet IDs
variable "private_subnet_ids" {
  type = list(string)
  description = "The private subnet IDs"
}

# Data Ingestion Security Group ID
variable "data_ingestion_security_group_id" {
  type = string
  description = "The ID of the data ingestion security group"
}

# Bootstrap S3 Bucket Terraform State
variable "bootstrap_s3_bucket_terraform_state" {
  type = string
  description = "The name of the bootstrap S3 bucket for Terraform state"
  default = "tf-air-quality-data-ingestion-bootstrap-state" 
}

# Step Function Scheduler Running State
variable "step_function_scheduler_running_state" {
  type = string
  description = "The running state of the step function scheduler"
}

# Step Function Schedule Expression
variable "step_function_schedule_expression" {
  type = string
  description = "The schedule expression of the step function"
}

# Datadog API Key
variable "datadog_api_key" {
  type = string
  description = "api key from datadog to authenticate"
}

# Datadog App Key
variable "datadog_app_key"{
  type = string
    description = "app key from datadog to authenticate"
}

# Datadog API URL
variable "datadog_api_url" {
  type = string
  description = "url of the datadog according to the region"
}

# Datadog Site
variable "datadog_site" {
  type = string
  description = "Datadog site url without https://"
}


# --- Image Versions Start ---

# Init Task Lambda Function Image Version
variable "init_task_lambda_function_image_version" {
  type = string
  description = "The image version for the init task lambda function"
}

# Extract Data Task ECS Task Image Version
variable "extract_data_task_ecs_task_image_version" {
  type = string
  description = "The image version for the extract data task ecs task"
}

# Create Batch Job Task Lambda Function Image Version
variable "create_batch_job_task_lambda_function_image_version" {
  type = string
  description = "The image version for the create batch job task lambda function"
}

# Transform Data Task Lambda Function Image Version
variable "transform_data_task_lambda_function_image_version" {
  type = string
  description = "The image version for the transform data task lambda function"
}

# Load Data Task ECS Task Image Version
variable "load_data_task_ecs_task_image_version" {
  type = string
  description = "The image version for the load data task ecs task"
}

# --- Image Versions End ---
