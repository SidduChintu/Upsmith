# Init Task (Lambda) ECR Repository URL
output "init_task_lambda_ecr_repository_url" {
  value = module.ecr_repositories.init_task_lambda_ecr_repository_url
}

# Extract Data Task ECR Repository URL
output "extract_data_task_ecr_repository_url" {
  value = module.ecr_repositories.extract_data_task_ecr_repository_url
}

# Create Batch Job Task (Lambda) ECR Repository URL
output "create_batch_job_task_lambda_ecr_repository_url" {
  value = module.ecr_repositories.create_batch_job_task_lambda_ecr_repository_url
}

# Transform Data Task (Lambda) ECR Repository URL
output "transform_data_task_lambda_ecr_repository_url" {
  value = module.ecr_repositories.transform_data_task_lambda_ecr_repository_url
}

# Load Data Task ECR Repository URL
output "load_data_task_ecr_repository_url" {
  value = module.ecr_repositories.load_data_task_ecr_repository_url
}
