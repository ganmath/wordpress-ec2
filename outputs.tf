output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.wordpress.public_ip
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.wordpress_backup.bucket
}
