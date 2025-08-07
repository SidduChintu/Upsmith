locals {
  common_tags = {
    Project = var.project_name
    Terraform = "true"
  }
}

# Air Quality Data Ingestion S3 Bucket - Prod
resource "aws_s3_bucket" "air_quality_data_ingestion_s3_bucket_prod" { 
  bucket = "${var.air_quality_data_ingestion_s3_bucket_name_prefix}-prod"

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = "${var.air_quality_data_ingestion_s3_bucket_name_prefix}-prod" 
    Environment = "prod"
  })
}

# Air Quality Data Ingestion S3 Bucket Public Access Block
resource "aws_s3_bucket_public_access_block" "air_quality_data_ingestion_s3_bucket_public_access_block_prod" {
  bucket = aws_s3_bucket.air_quality_data_ingestion_s3_bucket_prod.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


# Air Quality Data Ingestion S3 Bucket Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "air_quality_data_ingestion_s3_bucket_encryption_prod" {
  bucket = aws_s3_bucket.air_quality_data_ingestion_s3_bucket_prod.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Air Quality Data Ingestion S3 Bucket - Dev
resource "aws_s3_bucket" "air_quality_data_ingestion_s3_bucket_dev" {
  bucket = "${var.air_quality_data_ingestion_s3_bucket_name_prefix}-dev" 

  lifecycle {
    prevent_destroy = true
  }

  tags = merge(local.common_tags, {
    Name = "${var.air_quality_data_ingestion_s3_bucket_name_prefix}-dev" 
    Environment = "dev"
  })
}

# Air Quality Data Ingestion S3 Bucket Public Access Block - Dev
resource "aws_s3_bucket_public_access_block" "air_quality_data_ingestion_s3_bucket_public_access_block_dev" {
  bucket = aws_s3_bucket.air_quality_data_ingestion_s3_bucket_dev.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Air Quality Data Ingestion S3 Bucket Encryption - Dev
resource "aws_s3_bucket_server_side_encryption_configuration" "air_quality_data_ingestion_s3_bucket_encryption_dev" {
  bucket = aws_s3_bucket.air_quality_data_ingestion_s3_bucket_dev.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Air Quality Data Ingestion S3 Bucket - Local
resource "aws_s3_bucket" "air_quality_data_ingestion_s3_bucket_local" {
  bucket = "${var.air_quality_data_ingestion_s3_bucket_name_prefix}-local" 

  tags = merge(local.common_tags, {
    Name = "${var.air_quality_data_ingestion_s3_bucket_name_prefix}-local" 
    Environment = "local"
  })
}

# Air Quality Data Ingestion S3 Bucket Public Access Block - Local
resource "aws_s3_bucket_public_access_block" "air_quality_data_ingestion_s3_bucket_public_access_block_local" {
  bucket = aws_s3_bucket.air_quality_data_ingestion_s3_bucket_local.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Air Quality Data Ingestion S3 Bucket Encryption - Local
resource "aws_s3_bucket_server_side_encryption_configuration" "air_quality_data_ingestion_s3_bucket_encryption_local" {
  bucket = aws_s3_bucket.air_quality_data_ingestion_s3_bucket_local.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
