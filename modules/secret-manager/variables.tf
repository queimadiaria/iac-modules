variable "name" {
  description = "Nome do secret no AWS Secrets Manager."
  type        = string
}

variable "description" {
  description = "Descrição opcional do secret."
  type        = string
  default     = null
}

variable "secret_string" {
  description = "Valor do secret como string simples. Use este input ou secret_json."
  type        = string
  default     = null
  sensitive   = true
}

variable "secret_json" {
  description = "Mapa que será convertido para JSON e armazenado como secret string."
  type        = any
  default     = null
  sensitive   = true
}

variable "kms_key_id" {
  description = "KMS key opcional para criptografia do secret."
  type        = string
  default     = null
}

variable "recovery_window_in_days" {
  description = "Janela de recuperação ao destruir o secret."
  type        = number
  default     = 7
}

variable "tags" {
  description = "Tags aplicadas ao secret."
  type        = map(string)
  default     = {}
}