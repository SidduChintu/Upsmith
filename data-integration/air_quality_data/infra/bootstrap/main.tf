# Get the environment from the workspace
locals {
 
}

# S3
module "s3-buckets" {
  source = "./modules/s3"

  project_name = var.project_name
}

# ECR
module "ecr_repositories" {
  source = "./modules/ecr"

  project_name = var.project_name
}
