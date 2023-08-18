// Using data sources to access external resource attributes

data "aws_s3_bucket" "existing_bucket" {
  bucket = "sumeet.life"
}

output "bucket_id" {
  value = data.aws_s3_bucket.existing_bucket.id
}

output "bucket_arn" {
  value = data.aws_s3_bucket.existing_bucket.arn
}

output "bucket_region" {
  value = data.aws_s3_bucket.existing_bucket.region
}

output "bucket_domain_name" {
  value = data.aws_s3_bucket.existing_bucket.bucket_domain_name
}

// Will be printed only for S3 buckets with Static website hosting enabled
output "bucket_endpoint" {
  value = data.aws_s3_bucket.existing_bucket.website_endpoint
}

