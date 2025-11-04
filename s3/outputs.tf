output "bucket_name" { value = aws_s3_bucket.bucket1.bucket }
output "object_key" { value = aws_s3_object.data_s3.key }