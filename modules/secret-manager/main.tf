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
  name = "qd-${var.environment}-secretsmanager-role"

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

resource "aws_iam_policy" "secrets_read" {
  name        = "qd-${var.environment}-${var.service_name}-secrets-policy"

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
  role       = aws_iam_role.shared_ecs_role.name
  policy_arn = aws_iam_policy.secrets_read.arn
}