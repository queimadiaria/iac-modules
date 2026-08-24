resource "aws_secretsmanager_secret" "this" {
  name        = "qd/${var.environment}/microservice-${var.service_name}"
  description = "${var.service_name} secret in ${var.environment} environment" 

  tags = merge(
    var.tags,
    {
      Builder     = "Terraform"
      Application = var.service_name
      Environment = var.environment
    }
  )
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(var.custom_secrets)
}

data "aws_iam_role" "shared_ecs_role" {
  name = "QdEcsTaskService"
}