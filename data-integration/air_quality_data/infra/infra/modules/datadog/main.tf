locals {
  common_tags = {
    Project = var.project_name
    Environment = var.env
    Terraform = "true"
  }

}



# This block uses Terraform to deploy a CloudFormation stack, which in turn deploys Datadog’s official Lambda Forwarder.
# Automatically deploy Datadog’s log forwarder Lambda function using a CloudFormation template maintained by Datadog.

# DataDog Forwarder 
resource "aws_cloudformation_stack" "datadog_forwarder" {
  name         = "${var.forwarder_name}-${var.env}"
  capabilities = ["CAPABILITY_IAM", "CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
  # CAPABILITY_IAM -	Allows creation of IAM resources (roles/policies)
  # CAPABILITY_NAMED_IAM	Allows explicitly named IAM resources (e.g., a role called DatadogForwarderRole
  # CAPABILITY_AUTO_EXPAND	Allows use of macros and nested templates (not required here but safe to include)

  parameters = {
    DdApiKey     = var.datadog_api_key
    DdSite       = var.datadog_site
    FunctionName = "${var.forwarder_name}-${var.env}"
  }

  template_url = "https://datadog-cloudformation-template.s3.amazonaws.com/aws/forwarder/latest.yaml"

  tags = merge(local.common_tags, {
    Name = "${var.forwarder_name}-${var.env}"
  })
}

# Grants CloudWatch Logs permission to invoke the Datadog Forwarder Lambda.
resource "aws_lambda_permission" "allow_init_task_to_invoke_datadog_forwarder" {
  statement_id  = "AllowCloudWatchLogsToInvokeDatadogForwarderInitTask"
  action        = "lambda:InvokeFunction"
  function_name = aws_cloudformation_stack.datadog_forwarder.outputs["DatadogForwarderArn"]
  principal     = "logs.${var.aws_region}.amazonaws.com"
  source_arn    = "${data.aws_cloudwatch_log_group.init_task_lambda_log_group_name.arn}:*"
  source_account = var.aws_account_id
  depends_on = [
    aws_cloudformation_stack.datadog_forwarder,
    data.aws_cloudwatch_log_group.init_task_lambda_log_group_name
  ]

}

resource "aws_lambda_permission" "allow_create_task_to_invoke_datadog_forwarder" {
  statement_id  = "AllowCloudWatchLogsToInvokeDatadogForwarderCreateTask"
  action        = "lambda:InvokeFunction"
  function_name = aws_cloudformation_stack.datadog_forwarder.outputs["DatadogForwarderArn"]
  principal     = "logs.${var.aws_region}.amazonaws.com"
  source_arn    = "${data.aws_cloudwatch_log_group.create_batch_job_task_lambda_log_group_name.arn}:*"
  source_account = var.aws_account_id
  depends_on = [
    aws_cloudformation_stack.datadog_forwarder,
    data.aws_cloudwatch_log_group.create_batch_job_task_lambda_log_group_name
  ]
}

resource "aws_lambda_permission" "allow_transform_task_to_invoke_datadog_forwarder" {
  statement_id  = "AllowCloudWatchLogsToInvokeDatadogForwarderTransformTask"
  action        = "lambda:InvokeFunction"
  function_name = aws_cloudformation_stack.datadog_forwarder.outputs["DatadogForwarderArn"]
  principal     = "logs.${var.aws_region}.amazonaws.com"
  source_arn    = "${data.aws_cloudwatch_log_group.transform_data_task_lambda_log_group_name.arn}:*"
  source_account = var.aws_account_id
  depends_on = [
    aws_cloudformation_stack.datadog_forwarder,
    data.aws_cloudwatch_log_group.transform_data_task_lambda_log_group_name
  ]
}

resource "aws_lambda_permission" "allow_extract_task_to_invoke_datadog_forwarder" {
  statement_id  = "AllowCloudWatchLogsToInvokeDatadogForwarderExtractTask"
  action        = "lambda:InvokeFunction"
  function_name = aws_cloudformation_stack.datadog_forwarder.outputs["DatadogForwarderArn"]
  principal     = "logs.${var.aws_region}.amazonaws.com"
  source_arn    = "${data.aws_cloudwatch_log_group.extract_data_task_ecs_log_group_name.arn}:*"
  source_account = var.aws_account_id
  depends_on = [
    aws_cloudformation_stack.datadog_forwarder,
    data.aws_cloudwatch_log_group.extract_data_task_ecs_log_group_name
  ]
}

resource "aws_lambda_permission" "allow_load_task_to_invoke_datadog_forwarder" {
  statement_id  = "AllowCloudWatchLogsToInvokeDatadogForwarderLoadTask"
  action        = "lambda:InvokeFunction"
  function_name = aws_cloudformation_stack.datadog_forwarder.outputs["DatadogForwarderArn"]
  principal     = "logs.${var.aws_region}.amazonaws.com"
  source_arn    = "${data.aws_cloudwatch_log_group.load_data_task_ecs_log_group_name.arn}:*"
  source_account = var.aws_account_id
  depends_on = [
    aws_cloudformation_stack.datadog_forwarder,
    data.aws_cloudwatch_log_group.load_data_task_ecs_log_group_name
  ]
}

# Log subscription filters
resource "aws_cloudwatch_log_subscription_filter" "air_quality_init_task_dd_sub_filter" {
  name            = "${var.lambda_init_task_logs_name}-${var.env}"
  log_group_name  = data.aws_cloudwatch_log_group.init_task_lambda_log_group_name.name
  filter_pattern  = ""
  destination_arn = aws_cloudformation_stack.datadog_forwarder.outputs["DatadogForwarderArn"]
  
  depends_on = [
    aws_cloudformation_stack.datadog_forwarder,
    data.aws_cloudwatch_log_group.init_task_lambda_log_group_name
  ]
}

resource "aws_cloudwatch_log_subscription_filter" "air_quality_extract_data_dd_sub_filter" {
  name            = "${var.ecs_extract_data_task_logs_name}-${var.env}"
  log_group_name  = data.aws_cloudwatch_log_group.extract_data_task_ecs_log_group_name.name
  filter_pattern  = ""
  destination_arn = aws_cloudformation_stack.datadog_forwarder.outputs["DatadogForwarderArn"]
  
  depends_on = [
    aws_cloudformation_stack.datadog_forwarder,
    data.aws_cloudwatch_log_group.extract_data_task_ecs_log_group_name
  ]
}

resource "aws_cloudwatch_log_subscription_filter" "air_quality_create_batch_dd_sub_filter" {
  name            = "${var.lambda_create_batch_job_task_logs_name}-${var.env}"
  log_group_name  = data.aws_cloudwatch_log_group.create_batch_job_task_lambda_log_group_name.name
  filter_pattern  = ""
  destination_arn = aws_cloudformation_stack.datadog_forwarder.outputs["DatadogForwarderArn"]
  
  depends_on = [
    aws_cloudformation_stack.datadog_forwarder,
    data.aws_cloudwatch_log_group.create_batch_job_task_lambda_log_group_name
  ]
}

resource "aws_cloudwatch_log_subscription_filter" "air_quality_transform_data_dd_sub_filter" {
  name            = "${var.lambda_transform_data_task_logs_name}-${var.env}"
  log_group_name  = data.aws_cloudwatch_log_group.transform_data_task_lambda_log_group_name.name
  filter_pattern  = ""
  destination_arn = aws_cloudformation_stack.datadog_forwarder.outputs["DatadogForwarderArn"]

  depends_on = [
    aws_cloudformation_stack.datadog_forwarder,
    data.aws_cloudwatch_log_group.transform_data_task_lambda_log_group_name
  ]
}

resource "aws_cloudwatch_log_subscription_filter" "air_quality_load_data_dd_sub_filter" {
  name            = "${var.ecs_load_data_task_logs_name}-${var.env}"
  log_group_name  = data.aws_cloudwatch_log_group.load_data_task_ecs_log_group_name.name
  filter_pattern  = ""
  destination_arn = aws_cloudformation_stack.datadog_forwarder.outputs["DatadogForwarderArn"]
  
  depends_on = [
    aws_cloudformation_stack.datadog_forwarder,
    data.aws_cloudwatch_log_group.load_data_task_ecs_log_group_name
  ]
}


# resource "aws_iam_policy" "datadog_aws_integration" {
#   name   = "DatadogAWSIntegrationPolicy"
#   policy = data.aws_iam_policy_document.datadog_aws_integration.json
# }
# resource "aws_iam_role" "datadog_aws_integration" {
#   name               = "DatadogIntegrationRole"
#   description        = "Role for Datadog AWS Integration"
#   assume_role_policy = data.aws_iam_policy_document.datadog_aws_integration_assume_role.json
# }
# resource "aws_iam_role_policy_attachment" "datadog_aws_integration" {
#   role       = aws_iam_role.datadog_aws_integration.name
#   policy_arn = aws_iam_policy.datadog_aws_integration.arn
# }
# resource "aws_iam_role_policy_attachment" "datadog_aws_integration_security_audit" {
#   role       = aws_iam_role.datadog_aws_integration.name
#   policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
# }

# resource "datadog_integration_aws_account" "datadog_integration" {
#   account_tags   = []
#   aws_account_id = var.aws_account_id
#   aws_partition  = "aws"
#   aws_regions {
#     include_all = true
#   }
#   auth_config {
#     aws_auth_config_role {
#       role_name = "DatadogIntegrationRole"
#     }
#   }
#     resources_config {
#     cloud_security_posture_management_collection = true
#     extended_collection                          = true
#   }
#   traces_config {
#     xray_services {
#     }
#   }
#     logs_config {
#     lambda_forwarder {
#     }
#   }
#   metrics_config {
#     namespace_filters {
#     }
#   }
# }