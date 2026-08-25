resource "aws_secretsmanager_secret" "this" {
  name        = "qd/${var.environment}/global"

  tags = merge(
    var.tags,
    {
      Builder     = "Terraform"
      Environment = var.environment
      Type        = "Global"
    }
  )
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = jsonencode(var.custom_secrets)

  lifecycle {
    ignore_changes = [
      secret_string,
    ]
  }
}