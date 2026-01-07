variable "var-cidr" {
  type    = string
  default = "172.31.0.0/24"
}

variable "var-sub-autoip" {
  type    = bool
  default = true
}

variable "environment" {
  description = "whats it used for"
  type        = string
  default     = "dev"
}