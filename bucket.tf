resource "aws_s3_bucket" "wordpress_backup" {
  bucket = var.s3_bucket_name
  acl    = "private"

  tags = {
    Name        = "WordPress Backup Bucket"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_versioning" "wordpress_backup_versioning" {
  bucket = aws_s3_bucket.wordpress_backup.bucket

  versioning_configuration {
    status = "Enabled"
  }
}
