variable "aws_region" {
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "AMI ID"
  default     = "ami-0f58b397bc5c1f2e8"  # Update this to an Ubuntu AMI in your region
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "SSH Key Name"
  default = "myblog"
}

variable "nginx_config_url" {
  description = "URL to the Nginx config file"
  default     = "https://raw.githubusercontent.com/your-repo/nginx.conf"
}

variable "docker_compose_url" {
  description = "URL to the Docker Compose file"
  default     = "https://raw.githubusercontent.com/your-repo/docker-compose.yml"
}

variable "backup_script_url" {
  description = "URL to the backup script"
  default     = "https://raw.githubusercontent.com/your-repo/backup_wordpress.sh"
}

variable "restore_script_url" {
  description = "URL to the restore script"
  default     = "https://raw.githubusercontent.com/your-repo/restore_wordpress.sh"
}

variable "s3_bucket_name" {
  description = "S3 bucket name for WordPress backups"
  default     = "my-wordpress-backup-bucket"
}
