locals {
  secret_payload = var.secret_string != null ? var.secret_string : (
    var.secret_json != null ? jsonencode(var.secret_json) : null
  )
}

resource "aws_secretsmanager_secret" "this" {
  name                    = var.name
  description             = var.description
  kms_key_id              = var.kms_key_id
  recovery_window_in_days = var.recovery_window_in_days
  tags                    = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  count = local.secret_payload != null ? 1 : 0

  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = local.secret_payload
}