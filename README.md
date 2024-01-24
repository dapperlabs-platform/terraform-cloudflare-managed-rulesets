# terraform-cloudflare-managed-rulesets

## Cloudflare Managed Rulesets

This module creates the following cloudflare WAF managed ruleset:


### Cloudflare Managed Ruleset

 - Ruleset action (Required)
   - Default
 - Ruleset status
   - Default
 

### Cloudflare OWASP Core Ruleset

 - OWASP Anomaly Score Threshold (Required)
   - High - 25 and higher
    (Set the score threshold which will trigger the Firewall)
 - OWASP Paranoia Level (Required)
   - PL2
    (Higher paranoia levels activate more aggressive rules)
 - OWASP Action (Required)
   - Managed Challenge

### IMPORTANT
  
  - Order of the rules under the ruleset will set the priority/order
  
  - Any existing managed rules need to be deleted in the dashboard and recreated in terraform
