variable "environment" {
  description = "enviroment"
  type        = string
}

variable "service_name" {
  description = "service"
  type        = string
}

variable "custom_secrets" {
  description = "secrets"
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "tags" {
  description = "tag"
  type        = map(string)
  default     = {}
}