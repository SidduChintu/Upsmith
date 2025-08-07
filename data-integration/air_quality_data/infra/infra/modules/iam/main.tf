locals {
  common_tags = {
    Project = var.project_name
    Environment = var.env
    Terraform = "true"
  }
}

# Init Task Lambda Task IAM Role
resource "aws_iam_role" "init_task_lambda_task_iam_role" {
  name = "${var.init_task_lambda_task_iam_role_name}-${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name = "${var.init_task_lambda_task_iam_role_name}-${var.env}"
  })
}

# Init Task Lambda Task IAM Role Assume Role Policy
resource "aws_iam_role_policy" "init_task_lambda_task_iam_role_assume_role_policy" {
  name = "${var.init_task_lambda_task_iam_role_assume_role_policy}-${var.env}"
  role = aws_iam_role.init_task_lambda_task_iam_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:*"
      }
    ]
  })
}

# Create Batch Job Task Lambda Task IAM Role
resource "aws_iam_role" "create_batch_job_task_lambda_task_iam_role" {
  name = "${var.create_batch_job_task_lambda_task_iam_role_name}-${var.env}"

   assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name = "${var.create_batch_job_task_lambda_task_iam_role_name}-${var.env}"
  })
}

# Create Batch Job Task Lambda Task IAM Role Assume Role Policy
resource "aws_iam_role_policy" "create_batch_job_task_lambda_task_iam_role_assume_role_policy" {
  name = "${var.create_batch_job_task_lambda_task_iam_role_assume_role_policy}-${var.env}"
  role = aws_iam_role.create_batch_job_task_lambda_task_iam_role.name
   policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:*"
      },
      {
        Action = [
          "s3:Get*",
          "s3:List*",
          "s3:Describe*",
          "s3:PutObject",
          "s3-object-lambda:Get*",
          "s3-object-lambda:List*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Transform Data Task Lambda Function IAM Role
resource "aws_iam_role" "transform_data_task_lambda_function_iam_role" {
  name = "${var.transform_data_task_lambda_function_iam_role_name}-${var.env}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name = "${var.transform_data_task_lambda_function_iam_role_name}-${var.env}"
  })
}

# Transform Data Task Lambda Function IAM Role Assume Role Policy
resource "aws_iam_role_policy" "transform_data_task_lambda_function_iam_role_assume_role_policy" {
  name = "${var.transform_data_task_lambda_function_iam_role_assume_role_policy}-${var.env}"
  role = aws_iam_role.transform_data_task_lambda_function_iam_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:${var.aws_region}:${var.aws_account_id}:*"
      },
      {
        Action = [
          "s3:*",
          "s3-object-lambda:*",
          "secretsmanager:GetSecretValue"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# ECS Task IAM Role
resource "aws_iam_role" "ecs_task_iam_role" {
  name = "${var.ecs_task_iam_role_name}-${var.env}"

  assume_role_policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name = "${var.ecs_task_iam_role_name}-${var.env}"
  })
}

# ECS Task IAM Policy
resource "aws_iam_policy" "ecs_task_iam_policy" {
  name = "${var.ecs_task_iam_policy_name}-${var.env}"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:Describe*",
          "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
          "elasticloadbalancing:DeregisterTargets",
          "elasticloadbalancing:Describe*",
          "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
          "elasticloadbalancing:RegisterTargets"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:*",
          "s3-object-lambda:*"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ssm:DescribeAssociation",
          "ssm:GetDeployablePatchSnapshotForInstance",
          "ssm:GetDocument",
          "ssm:DescribeDocument",
          "ssm:GetManifest",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:ListAssociations",
          "ssm:ListInstanceAssociations",
          "ssm:PutInventory",
          "ssm:PutComplianceItems",
          "ssm:PutConfigurePackageResult",
          "ssm:UpdateAssociationStatus",
          "ssm:UpdateInstanceAssociationStatus",
          "ssm:UpdateInstanceInformation"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ec2messages:AcknowledgeMessage",
          "ec2messages:DeleteMessage",
          "ec2messages:FailMessage",
          "ec2messages:GetEndpoint",
          "ec2messages:GetMessages",
          "ec2messages:SendReply"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = "secretsmanager:GetSecretValue",
        Resource = "*"
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name = "${var.ecs_task_iam_policy_name}-${var.env}"
  })
}

# ECS Task IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "ecs_task_iam_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_iam_role.name
  policy_arn = aws_iam_policy.ecs_task_iam_policy.arn
}


# ECS Task Execution IAM Role
resource "aws_iam_role" "ecs_task_execution_iam_role" {
  name = "${var.ecs_task_execution_iam_role_name}-${var.env}"

  assume_role_policy = jsonencode({
    Version = "2008-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name = "${var.ecs_task_execution_iam_role_name}-${var.env}"
  })
}

# ECS Task Execution IAM Policy
resource "aws_iam_policy" "ecs_task_execution_iam_policy" {
  name = "${var.ecs_task_execution_iam_policy_name}-${var.env}"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:Describe*",
          "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
          "elasticloadbalancing:DeregisterTargets",
          "elasticloadbalancing:Describe*",
          "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
          "elasticloadbalancing:RegisterTargets"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ecs:ExecuteCommand",
          "ecs:DescribeTasks"
        ],
        Resource = "*"
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name = "${var.ecs_task_execution_iam_policy_name}-${var.env}"
  })
}

# ECS Task Execution IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "ecs_task_execution_iam_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_iam_role.name
  policy_arn = aws_iam_policy.ecs_task_execution_iam_policy.arn
}


# Step Function IAM Role
resource "aws_iam_role" "step_function_iam_role" {
  name = "${var.step_function_iam_role_name}-${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
      }
    ]
  })

  tags = merge(local.common_tags, {
    Name = "${var.step_function_iam_role_name}-${var.env}"
  })
}


# Step Function IAM Role Assume Role Policy
resource "aws_iam_role_policy" "step_function_iam_role_assume_role_policy" {
  name = "${var.step_function_iam_role_assume_role_policy}-${var.env}"
  role = aws_iam_role.step_function_iam_role.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action: [
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets"
        ],
        Resource: "*"
      },
      {
        Effect = "Allow",
        Action: "lambda:InvokeFunction",
        Resource: "*"
      },
      {
        Effect = "Allow",
        Action: [
          "events:PutTargets",
          "events:PutRule",
          "events:DescribeRule"
        ],
        Resource: "*"
      },
      {
        Effect = "Allow",
        Action: [
          "ecs:RunTask",
          "iam:PassRole"
        ],
        Resource: "*"
      },
      {
        Effect = "Allow",
        Action: [
          "states:StartExecution"
        ],
        Resource: "*"
      },
      {
        Effect = "Allow",
        Action: [
          "s3:GetObject",
        ]
        Resource: "*"
      },
      {
        Effect = "Allow",
        Action: [
          "states:RedriveExecution",
        ],
        Resource: "*"
      }
    ]
  })
}


# EventBridge to Invoke Step Function IAM Role
resource "aws_iam_role" "eventbridge_to_invoke_step_function_iam_role" {
  name = "${var.eventbridge_to_invoke_step_function_iam_role_name}-${var.env}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "events.amazonaws.com"
        }
      }
    ]
  })
}

# EventBridge to Invoke Step Function IAM Role Assume Role Policy
resource "aws_iam_role_policy" "eventbridge_to_invoke_step_function_iam_role_assume_role_policy" {
  name = "${var.eventbridge_to_invoke_step_function_iam_role_assume_role_policy}-${var.env}"
  role = aws_iam_role.eventbridge_to_invoke_step_function_iam_role.name

   policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "states:StartExecution",
        Resource = var.step_function_state_machine_arn
      }
    ]
  })
}



