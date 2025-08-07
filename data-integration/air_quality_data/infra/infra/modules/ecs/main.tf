locals {

  extract_data_task_ecr_repository_url = data.terraform_remote_state.bootstrap_terraform_state.outputs.extract_data_task_ecr_repository_url
  load_data_task_ecr_repository_url = data.terraform_remote_state.bootstrap_terraform_state.outputs.load_data_task_ecr_repository_url

  common_tags = {
    Project = var.project_name
    Environment = var.env
    Terraform = "true"
  }
}


# ECS Cluster with Fargate
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.ecs_cluster_name}-${var.env}"

  setting {
    name  = "containerInsights"
    value = "enhanced"
  }

  tags = merge(local.common_tags, {
    Name = "${var.ecs_cluster_name}-${var.env}"
  })
}

# CloudWatch Log Group for Extract Data Task
resource "aws_cloudwatch_log_group" "ecs_extract_data_task_logs" {
  name = "${var.ecs_extract_data_task_logs_name}-${var.env}"
  retention_in_days = 14

  tags = merge(local.common_tags, {
    Name = "${var.ecs_extract_data_task_logs_name}-${var.env}"
  })
}

# ECS Extract Data Task Definition
resource "aws_ecs_task_definition" "ecs_extract_data_task_definition" {
  family = "${var.ecs_extract_data_task_definition_name}-${var.env}"
  cpu = var.ecs_extract_data_task_cpu
  memory = var.ecs_extract_data_task_memory
  network_mode = "awsvpc"
  execution_role_arn = var.ecs_task_execution_iam_role_arn
  task_role_arn = var.ecs_task_iam_role_arn
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name = "task-runner",
      image = "${local.extract_data_task_ecr_repository_url}:${var.extract_data_task_ecs_task_image_version}",
      essential = true,
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group = aws_cloudwatch_log_group.ecs_extract_data_task_logs.name,
          awslogs-region = var.aws_region,
          awslogs-stream-prefix = "ecs",
          mode = "non-blocking",
          max-buffer-size = "25m"
        }
      }
    },
    {
      name = "aws-otel-collector",
      image = "public.ecr.aws/aws-observability/aws-otel-collector:v0.43.2",
      essential = true,
      command = ["--config=/etc/ecs/ecs-cloudwatch-xray.yaml"],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group  = "/ecs/ecs-aws-otel-sidecar-collector",
          awslogs-region = var.aws_region,
          awslogs-stream-prefix = "ecs",
          mode = "non-blocking",
          max-buffer-size = "25m"
        }
      }
    }
  ])

  tags = merge(local.common_tags, {
    Name = "${var.ecs_extract_data_task_definition_name}-${var.env}"
  })
}

# CloudWatch Log Group for Load Data Task
resource "aws_cloudwatch_log_group" "ecs_load_data_task_logs" {
  name = "${var.ecs_load_data_task_logs_name}-${var.env}"
  retention_in_days = 14

  tags = merge(local.common_tags, {
    Name = "${var.ecs_load_data_task_logs_name}-${var.env}"
  })
}

# ECS Load Data Task Definition
resource "aws_ecs_task_definition" "ecs_load_data_task_definition" {
  family = "${var.ecs_load_data_task_definition_name}-${var.env}"
  cpu = var.ecs_load_data_task_cpu
  memory = var.ecs_load_data_task_memory
  network_mode = "awsvpc"
  execution_role_arn = var.ecs_task_execution_iam_role_arn
  task_role_arn = var.ecs_task_iam_role_arn
  requires_compatibilities = ["FARGATE"]

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name = "task-runner",
      image = "${local.load_data_task_ecr_repository_url}:${var.load_data_task_ecs_task_image_version}",
      essential = true,
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group = aws_cloudwatch_log_group.ecs_load_data_task_logs.name,
          awslogs-region = var.aws_region,
          awslogs-stream-prefix = "ecs",
          mode = "non-blocking",
          max-buffer-size = "25m"
        }
      }
    },
    {
      name = "aws-otel-collector",
      image = "public.ecr.aws/aws-observability/aws-otel-collector:v0.43.2",
      essential = true,
      command = ["--config=/etc/ecs/ecs-cloudwatch-xray.yaml"],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group = "/ecs/ecs-aws-otel-sidecar-collector",
          awslogs-region = var.aws_region,
          awslogs-stream-prefix = "ecs",
          mode = "non-blocking",
          max-buffer-size = "25m"
        }
      }
    }
  ])

  tags = merge(local.common_tags, {
    Name = "${var.ecs_load_data_task_definition_name}-${var.env}"
  })
}

