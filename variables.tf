variable "domains" {
  type        = list(string)
  description = "Cloudflare Domain to be applied to"
  default     = []
}
variable "managed_ruleset_enabled" {
  type        = bool
  description = "Enable Cloudflare Managed Ruleset"
  default     = true
}

variable "owasp_enabled" {
  type        = bool
  description = "Enable OWASP Core Ruleset"
  default     = true
}
