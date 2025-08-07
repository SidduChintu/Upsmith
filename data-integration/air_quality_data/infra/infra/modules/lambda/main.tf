locals {
  init_task_ecr_repo_url = data.terraform_remote_state.bootstrap_terraform_state.outputs.init_task_lambda_ecr_repository_url
  create_batch_job_task_ecr_repo_url = data.terraform_remote_state.bootstrap_terraform_state.outputs.create_batch_job_task_lambda_ecr_repository_url
  transform_data_task_ecr_repo_url = data.terraform_remote_state.bootstrap_terraform_state.outputs.transform_data_task_lambda_ecr_repository_url
  common_tags = {
    Project = var.project_name
    Environment = var.env
    Terraform = "true"
  }
}

# Init Task (Lambda) Function with ECR Repository Image
resource "aws_lambda_function" "init_task_lambda_function" {
  function_name = "${var.init_task_lambda_function_name}-${var.env}"
  image_uri = "${local.init_task_ecr_repo_url}:${var.init_task_lambda_function_image_version}"
  role = var.init_task_lambda_task_iam_role_arn
  package_type = "Image"
  architectures = ["x86_64"]
  memory_size = 128 # 128MB
  timeout = 300 # 5mins

  tags = merge(local.common_tags, {
    Name = "${var.init_task_lambda_function_name}-${var.env}"
  })
}


# Create Batch Job (Lambda) Function with ECR Repository Image
resource "aws_lambda_function" "create_batch_job_task_lambda_function" {
  function_name = "${var.create_batch_job_task_lambda_function_name}-${var.env}"
  image_uri = "${local.create_batch_job_task_ecr_repo_url}:${var.create_batch_job_task_lambda_function_image_version}"
  role = var.create_batch_job_task_lambda_task_iam_role_arn
  package_type = "Image"
  architectures = ["x86_64"]
  memory_size = 512 # 512MB
  timeout = 300 # 5mins

  tags = merge(local.common_tags, {
    Name = "${var.create_batch_job_task_lambda_function_name}-${var.env}"
  })
}

# Transform Data Task (Lambda) Function with ECR Repository Image
resource "aws_lambda_function" "transform_data_task_lambda_function" {
  function_name = "${var.transform_data_task_lambda_function_name}-${var.env}"
  image_uri = "${local.transform_data_task_ecr_repo_url}:${var.transform_data_task_lambda_function_image_version}"
  role = var.transform_data_task_lambda_function_iam_role_arn
  package_type = "Image"
  architectures = ["x86_64"]
  memory_size = 1024 # 1GB
  timeout = 600 # 10mins

  tags = merge(local.common_tags, {
    Name = "${var.transform_data_task_lambda_function_name}-${var.env}"
  })
}
