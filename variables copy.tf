# variables.tf

variable "aws_region" {
  description = "The AWS region where the EC2 instance will be provisioned."
  default     = "ap-south-1"
}

variable "aws_ami_id" {
  description = "The ID of the AMI for the EC2 instance."
  default = "ami-0f58b397bc5c1f2e8"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the EC2 key pair to use for SSH access."
  default = "myblog"
}

variable "ssh_user" {
  description = "The SSH user to connect to the EC2 instance."
  default = "ec2-user"
}

variable "private_key_path" {
  description = "The file path to the private key for SSH access."
  default = "C:/ganesh/myblog.pem"
}

variable "instance_name" {
  description = "The name tag for the EC2 instance."
  default = "wordpress_instance"
}