variable "create_shared_role" {
  description = "create or use role"
  type        = bool
  default     = false
}

variable "environment" {
  type        = string
}

variable "service_name" {
  type        = string
}

variable "custom_secrets" {
  type        = map(string)
  default     = {}
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "region" {
  type        = string
  default     = "us-east-1"
}