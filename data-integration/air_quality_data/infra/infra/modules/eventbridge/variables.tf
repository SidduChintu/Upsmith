variable "project_name" {
  type = string
  description = "The name of the project"
}

variable "env" {
  type = string
  description = "The environment to deploy"
}

# Step Function State Machine ARN
variable "step_function_state_machine_arn" {
  type = string
  description = "The ARN of the step function state machine"
}

# EventBridge to Invoke Step Function IAM Role ARN
variable "eventbridge_to_invoke_step_function_iam_role_arn" {
  type = string
  description = "The ARN of the eventbridge to invoke step function iam role"
}

# EventBridge Schedule Name
variable "step_function_schedule_name" {
  type = string
  description = "The name of the step function schedule"
  default = "air-quality-data-ingestion-step-function-schedule"
}

# Step Function Scheduler Running State
variable "step_function_scheduler_running_state" {
  type = string
  description = "The running state of the step function scheduler"
  default = "ENABLED"
}

# Step Function Schedule Expression
variable "step_function_schedule_expression" {
  type = string
  description = "The schedule expression of the step function"
}
