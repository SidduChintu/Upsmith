locals {
  common_tags = {
    Project = var.project_name
    Environment = var.env
    Terraform = "true"
  }

  state_machine_definition = templatefile("${path.module}/state_machine_definition.json", {
    app_env = var.env
    init_task_lambda_function_arn = var.init_task_lambda_function_arn
    create_batch_job_task_lambda_function_arn = var.create_batch_job_task_lambda_function_arn
    ecs_cluster_arn = var.ecs_cluster_arn
    ecs_extract_data_task_definition_arn = var.ecs_extract_data_task_definition_arn
    transform_data_task_lambda_function_arn = var.transform_data_task_lambda_function_arn
    ecs_load_data_task_definition_arn = var.ecs_load_data_task_definition_arn
    step_function_state_machine_sg_id = var.step_function_state_machine_sg_id
    private_subnet_ids = var.private_subnet_ids[0]
  })
}

# Step Function State Machine
resource "aws_sfn_state_machine" "step_function_state_machine" {
  name = "${var.step_function_state_machine_name}-${var.env}"
  role_arn = var.step_function_iam_role_arn

  definition = local.state_machine_definition
  type = "STANDARD"

  tags = merge(local.common_tags, {
    Name = "${var.step_function_state_machine_name}-${var.env}"
  })
}

