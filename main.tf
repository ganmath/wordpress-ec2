terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "wordpress" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  security_groups = [aws_security_group.wordpress_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y docker.io docker-compose awscli
              mkdir -p /var/wp-site
              cd /var/wp-site
              wget ${var.nginx_config_url} -O nginx.conf
              wget ${var.docker_compose_url} -O docker-compose.yml
              docker-compose up -d
              wget ${var.backup_script_url} -O /usr/local/bin/backup_wordpress.sh
              wget ${var.restore_script_url} -O /usr/local/bin/restore_wordpress.sh
              chmod +x /usr/local/bin/backup_wordpress.sh /usr/local/bin/restore_wordpress.sh
              echo "0 2 * * * /usr/local/bin/backup_wordpress.sh" | crontab -
              EOF

  tags = {
    Name = "WordPressInstance"
  }
}

resource "aws_security_group" "wordpress_sg" {
  name        = "wordpress_security_group"
  description = "Allow web traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "wordpress_backup" {
  bucket = var.s3_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "WordPress Backup Bucket"
    Environment = "Production"
  }
}
