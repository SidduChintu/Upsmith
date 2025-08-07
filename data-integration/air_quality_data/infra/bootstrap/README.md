# Air Quality Data Bootstrap

## Overview
This directory contains Terraform code for bootstrapping foundational AWS resources required before deploying the main infrastructure. Typical resources include S3 buckets for remote Terraform state, DynamoDB tables for state locking, and ECR repositories for storing Docker images.

## Architecture
- **S3 Buckets:** Used for storing Terraform remote state and deployment artifacts.
- **DynamoDB Tables:** Used for Terraform state locking and consistency.
- **ECR Repositories:** Store Docker images for ECS tasks and Lambda functions.
- **Other foundational resources:** Any other resources required before main infrastructure provisioning.

## Directory Structure
```
bootstrap/
├── env/             # Environment-specific variable files
├── hcl/             # Backend configuration files for remote Terraform state
├── modules/         # Reusable Terraform modules for bootstrap resources
├── main.tf          # Main Terraform configuration for bootstrap resources
├── variables.tf     # Input variable definitions
├── outputs.tf       # Output values
├── providers.tf     # Provider configuration (e.g., AWS)
└── README.md        # This file
```

## Usage
1. Clone the repository and navigate to the `bootstrap` directory.
2. Initialize Terraform:
   ```sh
   terraform init -backend-config="hcl/backend-<env>.hcl"
   ```
3. Plan the deployment:
   ```sh
   terraform plan -var-file="env/<env>.tfvars"
   ```
4. Apply the deployment:
   ```sh
   terraform apply -var-file="env/<env>.tfvars"
   ```

## Inputs
| Name         | Description                                 | Type   | Default | Required |
|--------------|---------------------------------------------|--------|---------|----------|
| aws_region   | AWS region to deploy resources              | string |         | yes      |
| ...          | ...                                         | ...    | ...     | ...      |

*(List all important input variables here, or refer to `variables.tf` for the full list.)*


## Notes
- The resources in this folder should be deployed **before** running the main infrastructure Terraform code.
- S3 bucket and DynamoDB table names must be unique within your AWS account and region.
- Destroying these resources may break remote state for the main infrastructure.
