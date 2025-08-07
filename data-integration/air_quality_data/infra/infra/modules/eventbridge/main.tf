locals {
  common_tags = {
    Project = var.project_name
    Environment = var.env
    Terraform = "true"
  }
}

# EventBridge Rule to Invoke Step Function
resource "aws_cloudwatch_event_rule" "step_function_schedule" {
  name = "${var.step_function_schedule_name}-${var.env}"
  description = "EventBridge Rule to Invoke Step Function"
  schedule_expression = var.step_function_schedule_expression

  state = var.step_function_scheduler_running_state

  tags = merge(local.common_tags, {
    Name = "${var.step_function_schedule_name}-${var.env}"
  })
}

# EventBridge Rule to Invoke Step Function Target
resource "aws_cloudwatch_event_target" "trigger_step_function" {
  rule = aws_cloudwatch_event_rule.step_function_schedule.name
  arn = var.step_function_state_machine_arn
  role_arn = var.eventbridge_to_invoke_step_function_iam_role_arn
  input = jsonencode({})
}
