variable "project_name" {
  type = string
  description = "The name of the project"
}

variable "aws_region" {
  type = string
  description = "The AWS region"
}

variable "env" {
  type = string
  description = "The environment to deploy"
}

# Bootstrap S3 Bucket Terraform State
variable "bootstrap_s3_bucket_terraform_state" {
  type = string
  description = "The name of the bootstrap S3 bucket for Terraform state"
}

# Init Task Lambda Function Image Version
variable "init_task_lambda_function_image_version" {
  type = string
  description = "The image version for the init task lambda function"
}


# Init Task Lambda Task Role ARN
variable "init_task_lambda_task_iam_role_arn" {
  type = string
  description = "The ARN of the init task lambda task role"
}

# Init Task (Lambda) Function
variable "init_task_lambda_function_name" {
  type = string
  description = "The name of the init task lambda function"
  default = "air-quality-data-ingestion-init-task"
}

# Create Batch Job Task Lambda Function Image Version
variable "create_batch_job_task_lambda_function_image_version" {
  type = string
  description = "The image version for the create batch job task lambda function"
}

# Create Batch Job Lambda Task Role ARN
variable "create_batch_job_task_lambda_task_iam_role_arn" {
  type = string
  description = "The ARN of the create batch job task lambda task role"
}

# Create Batch Job (Lambda) Function
variable "create_batch_job_task_lambda_function_name" {
  type = string
  description = "The name of the create batch job task lambda function"
  default = "air-quality-data-ingestion-create-batch-job-task"
}

# Transform Data Task Lambda Function Image Version
variable "transform_data_task_lambda_function_image_version" {
  type = string
  description = "The image version for the transform data task lambda function"
}

# Transform Data Task Lambda Function IAM Role ARN
variable "transform_data_task_lambda_function_iam_role_arn" {
  type = string
  description = "The ARN of the transform data task lambda function"
}

# Transform Data Task Lambda Function
variable "transform_data_task_lambda_function_name" {
  type = string
  description = "The name of the transform data task lambda function"
  default = "air-quality-data-ingestion-transform-data-task"
}


