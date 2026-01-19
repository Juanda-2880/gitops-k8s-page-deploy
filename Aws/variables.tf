variable "aws_region" {
  type        = string
  description = "The AWS region where resources will be created."
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID where resources will be deployed."
}

variable "key_name" {
  type        = string
  description = "The name of the key pair to use for the EC2 instance."
}