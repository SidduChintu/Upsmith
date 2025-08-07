variable "project_name" {
  type = string
  description = "The name of the project"
}

variable "aws_region" {
  type = string
  description = "The AWS region"
}

variable "private_subnet_ids" {
  type = list(string)
  description = "The private subnet IDs"
}

variable "env" {
  type = string
  description = "The environment to deploy"
}

# Init Task Lambda Function ARN
variable "init_task_lambda_function_arn" {
  type = string
  description = "The ARN of the init task lambda function"
}

# Create Batch Job Task Lambda Function ARN
variable "create_batch_job_task_lambda_function_arn" {
  type = string
  description = "The ARN of the create batch job task lambda function"
}

# ECS Cluster ARN
variable "ecs_cluster_arn" {
  type = string
  description = "The ARN of the ecs cluster"
}

# ECS Extract Data Task Definition ARN
variable "ecs_extract_data_task_definition_arn" {
  type = string
  description = "The ARN of the extract data task definition"
}

# ECS Transform Data Lambda Function ARN
variable "transform_data_task_lambda_function_arn" {
  type = string
  description = "The ARN of the transform data lambda function"
}

# ECS Load Data Task Definition ARN
variable "ecs_load_data_task_definition_arn" {
  type = string
  description = "The ARN of the load data task definition"
}

# Step Function State Machine Security Group ID
variable "step_function_state_machine_sg_id" {
  type = string
  description = "The ID of the step function state machine security group"
}

# Step Function IAM Role ARN
variable "step_function_iam_role_arn" {
  type = string
  description = "The ARN of the step function iam role"
}

# Step Function State Machine Name
variable "step_function_state_machine_name" {
  type = string
  description = "The name of the step function state machine"
  default = "air-quality-data-ingestion-step-function-state-machine"
}

