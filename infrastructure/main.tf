provider "aws" {
  region = "eu-central-1"
}

provider "azurerm" {
  features {}
}

resource "aws_s3_bucket" "chat_logs" {
  bucket = "unser-letztes-project-chat-logs"
  acl    = "private"

  tags = {
    Name        = "Chat Logs"
    Environment = "Production"
  }
}

resource "aws_ecs_cluster" "chatbot_cluster" {
  name = "chatbot-cluster"
}

resource "aws_ecs_task_definition" "chatbot_task" {
  family                   = "chatbot-task"
  container_definitions    = jsonencode([
    {
      name      = "chatbot-container"
      image     = "your-ecr-repo:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 3001
          hostPort      = 3001
        }
      ]
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
}

resource "aws_ecs_service" "chatbot_service" {
  name            = "chatbot-service"
  cluster         = aws_ecs_cluster.chatbot_cluster.id
  task_definition = aws_ecs_task_definition.chatbot_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = ["subnet-12345678", "subnet-87654321"]
    assign_public_ip = true
  }
}

resource "azurerm_resource_group" "chatbot_rg" {
  name     = "chatbot-resources"
  location = "West Europe"
}

resource "azurerm_cognitive_account" "text_analytics" {
  name                = "chatbot-text-analytics"
  location            = azurerm_resource_group.chatbot_rg.location
  resource_group_name = azurerm_resource_group.chatbot_rg.name
  kind                = "TextAnalytics"
  sku_name            = "S0"
}