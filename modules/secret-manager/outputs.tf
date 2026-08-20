output "secret_arn" {
  description = "ARN do secret criado no AWS Secrets Manager"
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  description = "Nome completo do secret criado"
  value       = aws_secretsmanager_secret.this.name
}