# Init Task Lambda Task IAM Role ARN
output "init_task_lambda_task_iam_role_arn" {
  value = aws_iam_role.init_task_lambda_task_iam_role.arn
}

# Create Batch Job Task Lambda Task IAM Role ARN
output "create_batch_job_task_lambda_task_iam_role_arn" {
  value = aws_iam_role.create_batch_job_task_lambda_task_iam_role.arn
}

# Transform Data Task Lambda Function IAM Role ARN
output "transform_data_task_lambda_function_iam_role_arn" {
  value = aws_iam_role.transform_data_task_lambda_function_iam_role.arn
}

# ECS Task IAM Role ARN
output "ecs_task_iam_role_arn" {
  value = aws_iam_role.ecs_task_iam_role.arn
}

# ECS Task Execution IAM Role ARN
output "ecs_task_execution_iam_role_arn" {
  value = aws_iam_role.ecs_task_execution_iam_role.arn
}

# Step Function IAM Role ARN
output "step_function_iam_role_arn" {
  value = aws_iam_role.step_function_iam_role.arn
}

# EventBridge to Invoke Step Function IAM Role ARN
output "eventbridge_to_invoke_step_function_iam_role_arn" {
  value = aws_iam_role.eventbridge_to_invoke_step_function_iam_role.arn
}

