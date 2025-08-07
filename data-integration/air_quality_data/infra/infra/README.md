# Air Quality Data Infra

## Overview
This directory contains the main Terraform code to provision and manage the core infrastructure for the Air Quality Data Integration project. It brings together all modules and environment-specific configurations to deploy AWS resources such as Lambda functions, ECS tasks, Step Functions, EventBridge rules, IAM roles, and Datadog monitoring integrations.

## Architecture
- **Lambda Functions:** Used for data processing tasks.
- **ECS Tasks:** Run containerized workloads for data extraction and loading.
- **Step Functions:** Orchestrate the workflow between Lambda and ECS tasks.
- **EventBridge:** Schedules and triggers workflows.
- **IAM Roles:** Manage permissions for all AWS resources.
- **Datadog Forwarder:** Forwards logs from CloudWatch to Datadog for monitoring and alerting.
- **Other AWS Resources:** As defined by the included modules.

## Directory Structure
```
infra/
├── env/             # Environment-specific variable files
├── hcl/             # Backend configuration files for remote Terraform state
├── modules/         # Reusable Terraform modules (lambda, ecs, datadog, etc.)
├── main.tf          # Main Terraform configuration (composes all modules)
├── providers.tf     # Defines and configures Terraform providers
├── variables.tf     # Input variable definitions
├── outputs.tf       # Output values
└── README.md        # This file
```

## Usage
1. Clone the repository and navigate to the `infra` directory.
2. Update the variable files in `env/` as needed for your environment.
3. Initialize Terraform:
   ```sh
   terraform init -backend-config="hcl/backend-<env>.hcl"
   ```
4. Plan the deployment:
   ```sh
   terraform plan -var-file="env/<env>.tfvars"
   ```
5. Apply the deployment:
   ```sh
   terraform apply -var-file="env/<env>.tfvars"
   ```

## Inputs
| Name            | Description                                  | Type   | Default | Required |
|-----------------|----------------------------------------------|--------|---------|----------|
| env             | Deployment environment name                  | string |         | yes      |
| aws_region      | AWS region to deploy resources               | string |         | yes      |
| datadog_api_key | Datadog API key                              | string |         | yes      |
| datadog_site    | Datadog site (e.g. us5.datadoghq.com)        | string |         | yes      |
| ...             | ...                                          | ...    | ...     | ...      |

*Note: Some variables may be set by your workflow automation, but are required by the Terraform modules.*

*(List all important input variables here, or refer to `variables.tf` for the full list.)*

## Local Development & Debugging

> **Note:** The complete Terraform stack is designed for deployment to AWS and cannot be fully run or triggered in a local environment.  
> For local development, each function (such as Lambda functions or ECS tasks) must be run and debugged individually.

### Running Lambda Functions Locally

The following Lambda functions are part of this project:
- `init_task_lambda`
- `create_batch_job_task_lambda`
- `transform_data_task_lambda`

To run and debug these locally:
- Use [AWS SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli.html), [LocalStack](https://docs.localstack.cloud/), or [Docker](https://docs.docker.com/) to invoke and debug Lambda functions.
- Example with AWS SAM:
  ```sh
  sam local invoke InitTaskLambdaFunction -e events/init_event.json
  sam local invoke CreateBatchJobTaskLambdaFunction -e events/create_batch_event.json
  sam local invoke TransformDataTaskLambdaFunction -e events/transform_event.json
  ```
- You may need to mock AWS services or provide sample event payloads for local testing.

### Running ECS Tasks Locally

The following ECS tasks are part of this project:
- `extract_data_task` (Docker image: `extract-data-task`)
- `load_data_task` (Docker image: `load-data-task`)

To run and debug these locally:
- Use Docker to run the ECS task containers:
  ```sh
  docker run -it <your-ecr-repo>/extract-data-task:<tag>
  docker run -it <your-ecr-repo>/load-data-task:<tag>
  ```
- Provide any required environment variables or configuration files as needed for local testing.

### Limitations

- **You cannot deploy or trigger the entire stack locally.**  
  Only individual components (functions/containers) can be tested in isolation.
- Integration between AWS services (e.g., Step Functions, EventBridge, IAM, Datadog) must be tested in a deployed AWS environment.

## Dependencies
- [Terraform](https://www.terraform.io/) >= 1.0
- AWS account with appropriate permissions
- [Datadog account](https://www.datadoghq.com/) and API key

## How to Destroy
To destroy all resources created by this module:
```sh
terraform destroy -var-file="env/<env>.tfvars"
```

## Notes
- Ensure your AWS credentials are configured before running Terraform commands.
- Some resources (like log groups) may require a two-step apply if they are created by other modules.
- For troubleshooting Datadog log forwarding, check the Datadog Forwarder Lambda logs in CloudWatch.