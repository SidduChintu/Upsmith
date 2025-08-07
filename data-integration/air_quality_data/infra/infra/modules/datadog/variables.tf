variable "project_name" {
  type = string
  description = "The name of the project"
}

variable "aws_region" {
  type = string
  description = "The AWS region"
}

variable "aws_account_id" {
  type = string
  description = "The AWS account ID"
}


variable "datadog_api_key" {
  description = "api key from datadog to authenticate"
}

variable "datadog_app_key"{
    description = "app key from datadog to authenticate"
}

variable "datadog_api_url" {
  description = "url of the datadog according to the region"
}

variable "env" {
  type = string
  description = "The environment to deploy"
}

variable "datadog_site" {
  description = "Datadog site url without https://"
}

variable "forwarder_name" {
  description = "Name of the datadog forwarder"
  default     = "air-quality-data-datadog-forwarder"
}

# Log subscription filter names
variable "lambda_init_task_logs_name" {
  description = "CloudWatch log group name for air-quality init task Lambda function"
  type        = string
  default     = "air-quality-init-task-dd-sub-filter"
}

variable "ecs_extract_data_task_logs_name" {
  description = "CloudWatch log group name for air-quality extract data ECS task"
  type        = string
  default     = "air-quality-extract-data-dd-sub-filter"
}

variable "lambda_create_batch_job_task_logs_name" {
  description = "CloudWatch log group name for air-quality create batch job task Lambda function"
  type        = string
  default     = "air-quality-create-batch-job-task-dd-sub-filter"
}

variable "lambda_transform_data_task_logs_name" {
  description = "CloudWatch log group name for air-quality transform data task Lambda function"
  type        = string
  default     = "air-quality-transform-data-task-dd-sub-filter"
}

variable "ecs_load_data_task_logs_name" {
  description = "CloudWatch log group name for air-quality load data ECS task"
  type        = string
  default     = "air-quality-load-data-dd-sub-filter"
}



# Task function names
variable "init_task_lambda_function_name" {
  description = "The CloudWatch log group name for the Lambda init task"
  type        = string
}

variable "ecs_extract_data_task_log_group_name" {
  description = "The CloudWatch log group name for the ECS extract data task"
  type        = string
}

variable "create_batch_job_task_lambda_function_name" {
  description = "The CloudWatch log group name for the Lambda create batch job task"
  type        = string
}

variable "transform_data_task_lambda_function_name" {
  description = "The CloudWatch log group name for the Lambda transform data task"
  type        = string
}

variable "ecs_load_data_task_log_group_name" {
  description = "The CloudWatch log group name for the ECS load data task"
  type        = string
}


# The ARN of the Lambda function
variable "init_task_lambda_function_arn" {
  type = string
  description = "The ARN of the init task lambda function"
}

variable "create_batch_job_task_lambda_function_arn" {
  type = string
  description = "The ARN of the create batch job task lambda function"
}

variable "transform_data_task_lambda_function_arn" {
  type = string
  description = "The ARN of the transform data lambda function"
}

# The ARN of the ECS Cloud Watch log group
variable "extract_data_task_cloud_watch_log_group_arn" {
  type = string
  description = "The ARN of the transform data lambda function"
}

variable "load_data_task_cloud_watch_log_group_arn" {
  type = string
  description = "The ARN of the transform data lambda function"
}