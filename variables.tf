variable "domains" {
  type        = list(string)
  description = "Cloudflare Domain to be applied to"
  default     = []
}

variable "cloudflare_managed_ruleset" {
  type = object({
    enabled    = bool
    expression = string
    # override    = bool
  })
  default = {
    enabled    = true
    expression = ""
    # override    = false
  }
}

variable "cloudflare_owasp_core_ruleset" {
  type = object({
    enabled    = bool
    expression = string
    # override    = bool
  })
  default = {
    enabled    = true
    expression = ""
    # override    = false
  }

}
