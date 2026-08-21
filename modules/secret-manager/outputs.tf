output "secret_arn" {
  value = aws_secretsmanager_secret.this.arn
}

output "secret_name" {
  value = aws_secretsmanager_secret.this.name
}

output "shared_role_arn" {
  value = data.aws_iam_role.shared_ecs_role.arn
}

output "shared_role_name" {
  value = data.aws_iam_role.shared_ecs_role.name
}