output "s3_bucket_name" {
  description = "The name of the S3 bucket for chat logs"
  value       = aws_s3_bucket.chat_logs.bucket
}

output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.chatbot_cluster.id
}

output "cognitive_service_endpoint" {
  description = "The endpoint of the Azure Cognitive Services account"
  value       = azurerm_cognitive_account.text_analytics.endpoint
}
