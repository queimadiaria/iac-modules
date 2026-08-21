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

resource "aws_iam_role" "shared_ecs_role" {
  count = var.create_shared_role ? 1 : 0
  name  = "qd-${var.environment}-secretsmanager-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

data "aws_iam_role" "existing_shared_ecs_role" {
  count = var.create_shared_role ? 0 : 1
  name  = "qd-${var.environment}-secretsmanager-role"
}

locals {
  shared_role_arn  = var.create_shared_role ? aws_iam_role.shared_ecs_role[0].arn : data.aws_iam_role.existing_shared_ecs_role[0].arn
  shared_role_name = var.create_shared_role ? aws_iam_role.shared_ecs_role[0].name : data.aws_iam_role.existing_shared_ecs_role[0].name
}

resource "aws_iam_policy" "secrets_read" {
  name = "qd-${var.environment}-${var.service_name}-secrets-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "secretsmanager:GetSecretValue"
        Resource = [
          "arn:aws:secretsmanager:${var.region}:*:secret:qd/${var.environment}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_secrets" {
  role       = local.shared_role_name
  policy_arn = aws_iam_policy.secrets_read.arn
}