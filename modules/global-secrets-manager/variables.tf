variable "environment" {
  type        = string
}

variable "custom_secrets" {
  type        = map(string)
  default     = {
    INIT = "true"
  }
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "region" {
  type    = string
  default = "us-east-1"
}