output "secret_arn" {
  value       = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  value       = aws_secretsmanager_secret.this.name
}

output "policy_arn" {
  value       = aws_iam_policy.secrets_read.arn
}

output "shared_role_arn" {
  value       = local.shared_role_arn
}

output "shared_role_name" {
  value       = local.shared_role_name
}