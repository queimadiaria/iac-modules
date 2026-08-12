output "secret_arn" {
  description = "ARN do secret criado."
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  description = "Nome do secret criado."
  value       = aws_secretsmanager_secret.this.name
}

output "secret_id" {
  description = "ID do secret criado."
  value       = aws_secretsmanager_secret.this.id
}

output "secret_version_id" {
  description = "ID da versão inicial do secret, quando criada."
  value       = try(aws_secretsmanager_secret_version.this[0].version_id, null)
}

output "secret_value_from" {
  description = "Valor base para uso no ECS secrets.valueFrom."
  value       = aws_secretsmanager_secret.this.arn
}