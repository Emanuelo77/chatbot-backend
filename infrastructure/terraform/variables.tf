variable "aws_region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "eu-central-1"
}

variable "azure_location" {
  description = "The Azure region to create resources in"
  type        = string
  default     = "West Europe"
}

variable "bucket_name" {
  description = "The name of the S3 bucket for chat logs"
  type        = string
  default     = "unser-letztes-project-chat-logs"
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
  default     = "chatbot-cluster"
}

variable "subnet_ids" {
  description = "The subnet IDs for ECS service"
  type        = list(string)
  default     = ["subnet-12345678", "subnet-87654321"]
}
