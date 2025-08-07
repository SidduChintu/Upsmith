# Init Task (Lambda) ECR Repository URL
output "init_task_lambda_ecr_repository_url" {
  value = aws_ecr_repository.init_task_lambda_ecr_repository.repository_url
}

# Extract Data Task ECR Repository URL
output "extract_data_task_ecr_repository_url" {
  value = aws_ecr_repository.extract_data_task_ecr_repository.repository_url
}

# Create Batch Job Task (Lambda) ECR Repository URL
output "create_batch_job_task_lambda_ecr_repository_url" {
  value = aws_ecr_repository.create_batch_job_task_lambda_ecr_repository.repository_url
}

# Transform Data Task ECR Repository URL
output "transform_data_task_lambda_ecr_repository_url" {
  value = aws_ecr_repository.transform_data_task_lambda_ecr_repository.repository_url
}

# Load Data Task ECR Repository URL
output "load_data_task_ecr_repository_url" {
  value = aws_ecr_repository.load_data_task_ecr_repository.repository_url
}
