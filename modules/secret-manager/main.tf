resource "aws_secretsmanager_secret" "this" {
  # Estrutura do path: qd/dev/microservice-nome_do_servico
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

resource "aws_iam_policy" "secrets_read" {
  name        = "qd-${var.environment}-${var.service_name}-secrets-policy"
  description = "Permite a leitura do Secret Global e do Secret do microsservico em runtime"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "secretsmanager:GetSecretValue"
        Resource = [
          "arn:aws:secretsmanager:${var.region}:*:secret:qd/${var.environment}/global-*",
          aws_secretsmanager_secret.this.arn
        ]
      }
    ]
  })
}