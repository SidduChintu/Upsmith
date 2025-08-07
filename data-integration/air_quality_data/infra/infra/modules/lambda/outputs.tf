# Init Task Lambda Function ARN
output "init_task_lambda_function_arn" {
  value = aws_lambda_function.init_task_lambda_function.arn
}

# Create Batch Job Task Lambda Function ARN
output "create_batch_job_task_lambda_function_arn" {
  value = aws_lambda_function.create_batch_job_task_lambda_function.arn
}

# Transform Data Task Lambda Function ARN
output "transform_data_task_lambda_function_arn" {
  value = aws_lambda_function.transform_data_task_lambda_function.arn
}

output "init_task_lambda_function_name" {
  value = aws_lambda_function.init_task_lambda_function.function_name
}

output "create_batch_job_task_lambda_function_name" {
  value = aws_lambda_function.create_batch_job_task_lambda_function.function_name
}

output "transform_data_task_lambda_function_name" {
  value = aws_lambda_function.transform_data_task_lambda_function.function_name
}