data "cloudflare_zones" "zones" {
  count = length(var.domains)

  filter {
    name        = var.domains[count.index]
    lookup_type = "exact"
    paused      = false
  }
}

#resource "cloudflare_ruleset" "zone_level_managed_ruleset" {
#  count = length(var.domains)
#
#  zone_id = lookup(data.cloudflare_zones.zones[count.index].zones[0], "id")
#  name    = "Cloudflare Managed Ruleset"
#  kind    = "managed"
#  phase   = "http_request_firewall_managed"
#}

resource "cloudflare_ruleset" "zone_level_managed_waf" {
  count = length(var.domains)

  zone_id     = lookup(data.cloudflare_zones.zones[count.index].zones[0], "id")
  name        = "Cloudflare OWASP Core Ruleset"
  description = "Zone-level WAF Managed Rules config"
  kind        = "zone"
  phase       = "http_request_firewall_managed"

  rules {
    action = "execute"
    action_parameters {
      id      = "4814384a9e5d4991b9815dcfc25d2f1f"
      version = "latest"
      overrides {
        categories {
          category = "paranoia-level-2"
          action   = "block"
          enabled  = true
        }
        rules {
          id              = "6179ae15870a4bb7b2d480d4843b323c"
          action          = "managed_challenge"
          score_threshold = 25
        }
      }
    }
    expression  = "true"
    description = "Execute Cloudflare Managed Ruleset on my zone-level phase entry point ruleset"
    enabled     = true
  }
}
