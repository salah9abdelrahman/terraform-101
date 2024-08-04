output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "backend dynamodb name"
}

output "backend_s3_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "Backend S3 arn"
}
