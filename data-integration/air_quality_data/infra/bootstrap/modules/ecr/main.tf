locals {
 
  common_tags = {
    Project = var.project_name
    Terraform = "true"
    Shared = "true"
  }
}

# Init Task (Lambda) ECR Repository
resource "aws_ecr_repository" "init_task_lambda_ecr_repository" {
  name = var.init_task_lambda_ecr_repository_name

  tags = merge(local.common_tags, {
    Name = var.init_task_lambda_ecr_repository_name
  })
}

# Extract Data Task ECR Repository
resource "aws_ecr_repository" "extract_data_task_ecr_repository" {
  name = var.extract_data_task_ecr_repository_name

  tags = merge(local.common_tags, {
    Name = var.extract_data_task_ecr_repository_name
  })
}

# Create Batch Job Task (Lambda) ECR Repository
resource "aws_ecr_repository" "create_batch_job_task_lambda_ecr_repository" {
  name = var.create_batch_job_task_lambda_ecr_repository_name

  tags = merge(local.common_tags, {
    Name = var.create_batch_job_task_lambda_ecr_repository_name
  })
}

# Transform Data Task Lambda Function ECR Repository
resource "aws_ecr_repository" "transform_data_task_lambda_ecr_repository" {
  name = var.transform_data_task_lambda_ecr_repository_name

  tags = merge(local.common_tags, {
    Name = var.transform_data_task_lambda_ecr_repository_name
  })
}
# Load Data Task ECR Repository
resource "aws_ecr_repository" "load_data_task_ecr_repository" {
  name = var.load_data_task_ecr_repository_name

  tags = merge(local.common_tags, {
    Name = var.load_data_task_ecr_repository_name
  })
}
