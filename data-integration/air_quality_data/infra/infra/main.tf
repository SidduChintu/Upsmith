locals {
  # do not delete this comment
  # workspace_to_env = {
  #   prod  = "prod"
  #   local = "local"
  #   dev   = "dev"
  # }
  # env = can(local.workspace_to_env[terraform.workspace]) ? local.workspace_to_env[terraform.workspace] : tobool("Invalid workspace '${terraform.workspace}'. Must be one of: ${join(", ", keys(local.workspace_to_env))}")
  
}

# IAM
module "iam" {
  source = "./modules/iam"

  env = var.env
  project_name = var.project_name
  aws_region = var.aws_region
  aws_account_id = var.aws_account_id

  step_function_state_machine_arn = module.stepfunction.step_function_state_machine_arn
}

# module "sg" {
#   source = "./modules/sg"

#   env = var.env
#   project_name = var.project_name
#   aws_region = var.aws_region
#   vpc_id = var.vpc_id
# }

# Lambda
module "lambda" {
  source = "./modules/lambda"

  env = var.env
  project_name = var.project_name
  aws_region = var.aws_region

  bootstrap_s3_bucket_terraform_state = var.bootstrap_s3_bucket_terraform_state

  init_task_lambda_task_iam_role_arn = module.iam.init_task_lambda_task_iam_role_arn
  create_batch_job_task_lambda_task_iam_role_arn = module.iam.create_batch_job_task_lambda_task_iam_role_arn
  transform_data_task_lambda_function_iam_role_arn = module.iam.transform_data_task_lambda_function_iam_role_arn

  init_task_lambda_function_image_version = var.init_task_lambda_function_image_version
  create_batch_job_task_lambda_function_image_version = var.create_batch_job_task_lambda_function_image_version
  transform_data_task_lambda_function_image_version = var.transform_data_task_lambda_function_image_version  
  

  # depends_on = [ module.iam ]
}

# ECS
module "ecs" {
  source = "./modules/ecs"

  env = var.env
  project_name = var.project_name
  aws_region = var.aws_region


  bootstrap_s3_bucket_terraform_state = var.bootstrap_s3_bucket_terraform_state

  ecs_task_iam_role_arn = module.iam.ecs_task_iam_role_arn
  ecs_task_execution_iam_role_arn = module.iam.ecs_task_execution_iam_role_arn

  extract_data_task_ecs_task_image_version = var.extract_data_task_ecs_task_image_version
  load_data_task_ecs_task_image_version = var.load_data_task_ecs_task_image_version
}

# Step Function
module "stepfunction" {
  source = "./modules/stepfunction"

  env = var.env
  project_name = var.project_name
  aws_region = var.aws_region
  private_subnet_ids = var.private_subnet_ids

  # step_function_state_machine_sg_id = module.sg.step_function_state_machine_sg_id
  step_function_state_machine_sg_id = var.data_ingestion_security_group_id

  step_function_iam_role_arn = module.iam.step_function_iam_role_arn

  init_task_lambda_function_arn = module.lambda.init_task_lambda_function_arn
  create_batch_job_task_lambda_function_arn = module.lambda.create_batch_job_task_lambda_function_arn
  transform_data_task_lambda_function_arn = module.lambda.transform_data_task_lambda_function_arn

  ecs_cluster_arn = module.ecs.ecs_cluster_arn
  ecs_extract_data_task_definition_arn = module.ecs.ecs_extract_data_task_definition_arn
  ecs_load_data_task_definition_arn = module.ecs.ecs_load_data_task_definition_arn
  
  # depends_on = [ module.lambda, module.ecs ]
}


# EventBridge
module "eventbridge" {
  source = "./modules/eventbridge"

  env = var.env
  project_name = var.project_name

  step_function_scheduler_running_state = var.step_function_scheduler_running_state
  step_function_schedule_expression = var.step_function_schedule_expression
  
  step_function_state_machine_arn = module.stepfunction.step_function_state_machine_arn
  eventbridge_to_invoke_step_function_iam_role_arn = module.iam.eventbridge_to_invoke_step_function_iam_role_arn
  
}

# Datadog
module "datadog" {
  source = "./modules/datadog"

  env = var.env
  project_name = var.project_name
  aws_region = var.aws_region
  aws_account_id = var.aws_account_id

  datadog_api_key = var.datadog_api_key
  datadog_app_key = var.datadog_app_key
  datadog_api_url = var.datadog_api_key
  datadog_site = var.datadog_site

  init_task_lambda_function_name = module.lambda.init_task_lambda_function_name
  ecs_extract_data_task_log_group_name = module.ecs.ecs_extract_data_task_log_group_name
  create_batch_job_task_lambda_function_name = module.lambda.create_batch_job_task_lambda_function_name 
  transform_data_task_lambda_function_name = module.lambda.transform_data_task_lambda_function_name
  ecs_load_data_task_log_group_name = module.ecs.ecs_load_data_task_log_group_name

  init_task_lambda_function_arn = module.lambda.init_task_lambda_function_arn
  create_batch_job_task_lambda_function_arn = module.lambda.create_batch_job_task_lambda_function_arn
  transform_data_task_lambda_function_arn = module.lambda.transform_data_task_lambda_function_arn
  extract_data_task_cloud_watch_log_group_arn = module.ecs.extract_data_task_cloud_watch_log_group_arn
  load_data_task_cloud_watch_log_group_arn = module.ecs.load_data_task_cloud_watch_log_group_arn

}