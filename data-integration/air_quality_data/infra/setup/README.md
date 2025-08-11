# Air Quality Data Setup


## Overview
This Terraform module is responsible for provisioning all foundational resources required to securely manage Terraform state and state locking for both **Bootstrap** and **Infra** stages.


## Architecture
- **S3 Bucket (Bootstrap):** Stores Terraform state files securely for the bootstrap phase.
- **DynamoDB Table (Bootstrap):** Enables state locking and consistency for the bootstrap phase.
- **KMS Key (Bootstrap):** Encrypts the bootstrap S3 bucket contents.
- **S3 Bucket (Infra):** Stores Terraform state for the main infrastructure.
- **DynamoDB Table (Infra):** Manages state locking during infrastructure changes.
- **KMS Key (Infra):** Encrypts infra-related state files in S3.
- **Other AWS Resources:** As defined by the included modules.


## Directory Structure
```
setup/
├── main.tf          # Main Terraform configuration (composes all modules)
├── providers.tf     # Defines and configures Terraform providers
├── variables.tf     # Input variable definitions
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