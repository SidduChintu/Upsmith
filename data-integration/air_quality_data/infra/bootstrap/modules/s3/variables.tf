variable "project_name" {
  type = string
  description = "The name of the project"
}

# Air Quality Data Ingestion S3 Bucket Name
variable "air_quality_data_ingestion_s3_bucket_name_prefix" {
  type = string
  description = "The prefix of the air quality data ingestion s3 bucket"
  default = "air-quality-data-ingestion-data"
}

