variable "project_name" {
  type = string
  description = "The name of the project"
}

variable "aws_region" {
  type = string
  description = "The AWS region"
}

variable "aws_account_id" {
  type = string
  description = "The AWS account ID"
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


# Init Task Lambda Task IAM Role
variable "init_task_lambda_task_iam_role_name" {
  type = string
  description = "The prefix of the init task lambda task iam role"
  default = "air-quality-data-ingestion-init-task-lambda-iam-role"
}

# Init Task Lambda Task Role Assume Role Policy
variable "init_task_lambda_task_iam_role_assume_role_policy" {
  type = string
  description = "The prefix of the assume role policy of the init task lambda task iam role"
  default = "air-quality-data-ingestion-init-task-lambda-iam-role-assume-role-policy"
}

# Create Batch Job Task Lambda Task IAM Role
variable "create_batch_job_task_lambda_task_iam_role_name" {
  type = string
  description = "The name of the create batch job task lambda task iam role"
  default = "air-quality-data-ingestion-create-batch-job-lambda-role"
}

# Create Batch Job Task Lambda Task Role Assume Role Policy
variable "create_batch_job_task_lambda_task_iam_role_assume_role_policy" {
  type = string
  description = "The assume role policy of the create batch job task lambda task iam role"
  default = "air-quality-data-ingestion-create-batch-job-task-lambda-iam-role-assume-role-policy"
}

# Transform Data Task Lambda Function IAM Role
variable "transform_data_task_lambda_function_iam_role_name" {
  type = string
  description = "The name of the transform data task lambda function iam role"
  default = "air-quality-data-ingestion-transform-data-task-lambda-role"
}

# Transform Data Task Lambda Function IAM Role Assume Role Policy
variable "transform_data_task_lambda_function_iam_role_assume_role_policy" {
  type = string
  description = "The assume role policy of the transform data task lambda function iam role"
  default = "air-quality-data-ingestion-transform-data-task-lambda-iam-role-assume-role-policy"
}

# ECS Task IAM Role
variable "ecs_task_iam_role_name" {
  type = string
  description = "The name of the ecs task iam role"
  default = "air-quality-data-ingestion-ecs-task-iam-role"
}

# ECS Task IAM Policy
variable "ecs_task_iam_policy_name" {
  type = string
  description = "The name of the ecs task iam policy"
  default = "air-quality-data-ingestion-ecs-task-iam-policy"
}

# ECS Task Execution IAM Role
variable "ecs_task_execution_iam_role_name" {
  type = string
  description = "The name of the ecs task execution iam role"
  default = "air-quality-data-ingestion-ecs-task-execution-iam-role"
}


# ECS Task Execution IAM Policy
variable "ecs_task_execution_iam_policy_name" {
  type = string
  description = "The name of the ecs task execution iam policy"
  default = "air-quality-data-ingestion-ecs-task-execution-iam-policy"
}

# Step Function IAM Role
variable "step_function_iam_role_name" {
  type = string
  description = "The name of the step function iam role"
  default = "air-quality-data-ingestion-step-function-iam-role"
}

# Step Function IAM Role Assume Role Policy
variable "step_function_iam_role_assume_role_policy" {
  type = string
  description = "The assume role policy of the step function iam role"
  default = "air-quality-data-ingestion-step-function-iam-role-assume-role-policy"
}


# EventBridge to Invoke Step Function IAM Role
variable "eventbridge_to_invoke_step_function_iam_role_name" {
  type = string
  description = "The name of the eventbridge to invoke step function iam role"
  default = "air-quality-data-ingestion-eventbridge-invoker-iam-role"
}

# EventBridge to Invoke Step Function IAM Role Assume Role Policy
variable "eventbridge_to_invoke_step_function_iam_role_assume_role_policy" {
  type = string
  description = "The assume role policy of the eventbridge to invoke step function iam role"
  default = "air-quality-data-ingestion-eventbridge-invoker-iam-role-assume-role-policy"
}


