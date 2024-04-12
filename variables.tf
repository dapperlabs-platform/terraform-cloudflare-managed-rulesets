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

variable "owasp_action" {
  type        = string
  description = "OWASP Core Ruleset action"
  default     = "log"
}

variable "anomaly_score_threshold" {
  type        = number
  description = "OWASP Core Ruleset anomaly score threshold"
  default     = 60

}

variable "paranoia_level" {
  type        = number
  description = "OWASP Core Ruleset paranoia level"
  default     = 3

}
