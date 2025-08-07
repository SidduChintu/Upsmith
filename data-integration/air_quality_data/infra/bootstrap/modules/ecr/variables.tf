variable "project_name" {
  type = string
  description = "The name of the project"
}

# Init Task (Lambda) ECR Repository Name
variable "init_task_lambda_ecr_repository_name" {
  type = string
  description = "The name of the init task lambda ecr repository"
  default = "air-quality-data-ingestion/init-task-lambda"
}

# Extract Data Task ECR Repository Name
variable "extract_data_task_ecr_repository_name" {
  type = string
  description = "The name of the extract data task ecr repository"
  default = "air-quality-data-ingestion/extract-data-task"
}

# Create Batch Job Task (Lambda) ECR Repository Name
variable "create_batch_job_task_lambda_ecr_repository_name" {
  type = string
  description = "The name of the create batch job task lambda ecr repository"
  default = "air-quality-data-ingestion/create-batch-job-lambda"
}

# Transform Data Task (Lambda) ECR Repository Name
variable "transform_data_task_lambda_ecr_repository_name" {
  type = string
  description = "The name of the transform data task lambda ecr repository"
  default = "air-quality-data-ingestion/transform-data-task-lambda"
}

# Load Data Task ECR Repository Name
variable "load_data_task_ecr_repository_name" {
  type = string
  description = "The name of the load data task ecr repository"
  default = "air-quality-data-ingestion/load-data-task"
}
