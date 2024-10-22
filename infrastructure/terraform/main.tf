provider "aws" {
  region = var.aws_region
}

provider "azurerm" {
  features {}
}

resource "aws_s3_bucket" "chat_logs" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name        = "Chat Logs"
    Environment = "Production"
  }
}

resource "aws_ecs_cluster" "chatbot_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_service" "chatbot_service" {
  name            = "chatbot-service"
  cluster         = aws_ecs_cluster.chatbot_cluster.id
  task_definition = aws_ecs_task_definition.chatbot_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
  }
}

resource "azurerm_resource_group" "chatbot_rg" {
  name     = "chatbot-resources"
  location = var.azure_location
}
