data "cloudflare_zones" "zones" {
  count = length(var.domains)

  filter {
    name        = var.domains[count.index]
    lookup_type = "exact"
    paused      = false
  }
}

resource "cloudflare_ruleset" "zone_level_managed_ruleset" {
  count = length(var.domains)

  zone_id = lookup(data.cloudflare_zones.zones[count.index].zones[0], "id")
  name    = "Cloudflare Managed Ruleset"
  kind    = "zone"
  phase   = "http_request_firewall_managed"

  rules {
    action = "execute"
    action_parameters {
      id = "efb7b8c949ac4650a09736fc376e9aee"
    }
    expression  = var.cloudflare_managed_ruleset.expression
    description = "Execute Cloudflare Managed Ruleset on my zone-level phase entry point ruleset"
    enabled     = var.cloudflare_managed_ruleset.enabled
  }
}

resource "cloudflare_ruleset" "zone_level_owasp_ruleset" {
  count = length(var.domains)

  zone_id = lookup(data.cloudflare_zones.zones[count.index].zones[0], "id")
  name    = "Cloudflare OWASP Core Ruleset"
  kind    = "zone"
  phase   = "http_request_firewall_managed"

  rules {
    action = "execute"
    action_parameters {
      id = "4814384a9e5d4991b9815dcfc25d2f1f"
      overrides {
        categories {
          category = "paranoia-level-3"
          enabled  = false
        }
        categories {
          category = "paranoia-level-4"
          enabled  = false
        }
        rules {
          id              = "6179ae15870a4bb7b2d480d4843b323c"
          action          = "managed_challenge"
          score_threshold = 25
        }
      }
    }
    expression  = var.cloudflare_owasp_core_ruleset.expression
    description = "Execute Cloudflare Managed Ruleset on my zone-level phase entry point ruleset"
    enabled     = var.cloudflare_owasp_core_ruleset.enabled
  }
}
