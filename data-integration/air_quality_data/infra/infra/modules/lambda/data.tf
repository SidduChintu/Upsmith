data "terraform_remote_state" "bootstrap_terraform_state" {
  backend = "s3"
  config = {
    bucket         = var.bootstrap_s3_bucket_terraform_state
    key            = "terraform.tfstate"
    # key            = "workspaces/${local.env}/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
  }
}
