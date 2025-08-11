# Bootstrap TFState Bucket
resource "aws_s3_bucket" "bootstrap_tfstate_bucket" {
  bucket = var.bootstrap_tfstate_bucket_name
}

# Infra TFState Bucket
resource "aws_s3_bucket" "infra_tfstate_bucket" {
  bucket = var.infra_tfstate_bucket_name
}

# Bootstrap Bucket Crypto Configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "bootstrap_tfstate_bucket_crypto_conf" {
  bucket = aws_s3_bucket.bootstrap_tfstate_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Infra TFState Bucket Crypto Configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "infra_tfstate_bucket_crypto_conf" {
  bucket = aws_s3_bucket.infra_tfstate_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bootstrap TFState Bucket Versioning
resource "aws_s3_bucket_versioning" "bootstrap_tfstate_bucket_versioning" {
  bucket = aws_s3_bucket.bootstrap_tfstate_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Infra TFState Bucket Versioning
resource "aws_s3_bucket_versioning" "infra_tfstate_bucket_versioning" {
  bucket = aws_s3_bucket.infra_tfstate_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Bootstrap TFLock DynamoDB Table
resource "aws_dynamodb_table" "bootstrap_tflock_dynamodb_table" {
  name = var.bootstrap_tflock_dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Infra TFLock DynamoDB Table
resource "aws_dynamodb_table" "infra_tflock_dynamodb_table" {
  name = var.infra_tflock_dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
