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

# ECS Task IAM Role ARN
variable "ecs_task_iam_role_arn" {
  type = string
  description = "The name of the ecs task iam role"
}

# ECS Task Execution IAM Role ARN
variable "ecs_task_execution_iam_role_arn" {
  type = string
  description = "The name of the ecs task execution iam role"
}


# ECS Cluster
variable "ecs_cluster_name" {
  type = string
  description = "The name of the ecs cluster"
  default = "air-quality-data-ingestion-ecs-cluster"
}

# CloudWatch Log Group for Extract Data Task
variable "ecs_extract_data_task_logs_name" {
  type = string
  description = "The name of the cloudwatch log group for the extract data task"
  default = "/ecs/air-quality-data-ingestion-extract-data-task"
}

# ECS Extract Data Task CPU
variable "ecs_extract_data_task_cpu" {
  type = number
  description = "The cpu for the extract data task"
  default = 512
}

# ECS Extract Data Task Memory
variable "ecs_extract_data_task_memory" {
  type = number
  description = "The memory for the extract data task"
  default = 1024
}

# ECS Extract Data Task Image Version
variable "extract_data_task_ecs_task_image_version" {
  type = string
  description = "The image version for the extract data task"
}

# ECS Extract Data Task Definition
variable "ecs_extract_data_task_definition_name" {
  type = string
  description = "The name of the ecs task definition"
  default = "air-quality-data-ingestion-ecs-extract-data-task-definition"
}

# CloudWatch Log Group for Load Data Task
variable "ecs_load_data_task_logs_name" {
  type = string
  description = "The name of the cloudwatch log group for the load data task"
  default = "/ecs/air-quality-data-ingestion-load-data-task"
}

# ECS Load Data Task CPU
variable "ecs_load_data_task_cpu" {
  type = number
  description = "The cpu for the load data task"
  default = 1024
}

# ECS Load Data Task Memory
variable "ecs_load_data_task_memory" {
  type = number
  description = "The memory for the load data task"
  default = 4096
}

# ECS Load Data Task Image Version
variable "load_data_task_ecs_task_image_version" {
  type = string
  description = "The image version for the load data task"
}

# ECS Load Data Task Definition
variable "ecs_load_data_task_definition_name" {
  type = string
  description = "The name of the ecs task definition"
  default = "air-quality-data-ingestion-ecs-load-data-task-definition"
}