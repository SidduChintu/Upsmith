# ECS Cluster ARN
output "ecs_cluster_arn" {
  value = aws_ecs_cluster.ecs_cluster.arn
}

# ECS Extract Data Task Definition ARN
output "ecs_extract_data_task_definition_arn" {
  value = aws_ecs_task_definition.ecs_extract_data_task_definition.arn
}

# ECS Load Data Task Definition ARN
output "ecs_load_data_task_definition_arn" {
  value = aws_ecs_task_definition.ecs_load_data_task_definition.arn
}

# ECS Extract Data Task Log Group Name
output "ecs_extract_data_task_log_group_name" {
  description = "The CloudWatch log group name for the ECS extract data task"
  value       = aws_cloudwatch_log_group.ecs_extract_data_task_logs.name
}

# ECS Load Data Task Log Group Name
output "ecs_load_data_task_log_group_name" {
  description = "The CloudWatch log group name for the ECS load data task"
  value       = aws_cloudwatch_log_group.ecs_load_data_task_logs.name
}

# ECS Extract Data Task CloudWatch Log Group ARN
output "extract_data_task_cloud_watch_log_group_arn" {
  description = "The CloudWatch log group ARN for the ECS extract data task"
  value       = aws_cloudwatch_log_group.ecs_extract_data_task_logs.arn
}

# ECS Load Data Task CloudWatch Log Group ARN
output "load_data_task_cloud_watch_log_group_arn" {
  description = "The CloudWatch log group name for the ECS load data task"
  value       = aws_cloudwatch_log_group.ecs_load_data_task_logs.arn
}