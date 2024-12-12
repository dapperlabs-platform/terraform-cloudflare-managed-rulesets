locals {
  category_settings = {
    "1" = [
      { category = "paranoia-level-2", enabled = false },
      { category = "paranoia-level-3", enabled = false },
      { category = "paranoia-level-4", enabled = false }
    ],
    "2" = [
      { category = "paranoia-level-3", enabled = false },
      { category = "paranoia-level-4", enabled = false }
    ],
    "3" = [
      { category = "paranoia-level-4", enabled = false }
    ],
    "4" = []
  }
}



data "cloudflare_zones" "zones" {
  count = length(var.domains)

  filter {
    name        = var.domains[count.index]
    lookup_type = "exact"
    paused      = false
  }
}


resource "cloudflare_ruleset" "zone_level_managed_waf" {
  count = length(var.domains)

  zone_id     = lookup(data.cloudflare_zones.zones[count.index].zones[0], "id")
  name        = "Cloudflare Managed Ruleset"
  description = "Zone-level WAF Managed Rules config"
  kind        = "zone"
  phase       = "http_request_firewall_managed"

  # Managed Ruleset
  rules {
    action = "execute"
    action_parameters {
      id = "efb7b8c949ac4650a09736fc376e9aee"
    }
    expression  = "true"
    description = "Execute Cloudflare Managed Ruleset on my zone-level phase entry point ruleset"
    enabled     = var.managed_ruleset_enabled
  }

  # OWASP Core Ruleset
  rules {
    action = "execute"
    action_parameters {
      id      = "4814384a9e5d4991b9815dcfc25d2f1f"
      overrides {
        dynamic "categories" {
          for_each = local.category_settings[tostring(var.paranoia_level)]
          content {
            category = categories.value.category
            enabled  = categories.value.enabled
          }
        }

        rules {
          id              = "6179ae15870a4bb7b2d480d4843b323c"
          action          = var.owasp_action
          score_threshold = var.anomaly_score_threshold
        }
      }
    }
    expression  = "true"
    description = "Execute Cloudflare Managed Ruleset on my zone-level phase entry point ruleset"
    enabled     = var.owasp_enabled
  }
}
