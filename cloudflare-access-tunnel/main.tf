#==============================================================================
# REMOTELY MANAGED CLOUDFLARE TUNNEL
#==============================================================================

resource "cloudflare_zero_trust_tunnel_cloudflared" "this" {
  account_id = var.account_id
  name       = var.tunnel_name
  config_src = "cloudflare"
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "this" {
  account_id = var.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id
  source     = "cloudflare"

  config = {
    ingress = concat(
      [
        for route_name in sort(keys(var.routes)) : {
          hostname = var.routes[route_name].hostname
          service  = var.routes[route_name].service
        }
      ],
      [
        {
          service = "http_status:404"
        }
      ]
    )
  }
}

data "cloudflare_zero_trust_tunnel_cloudflared_token" "this" {
  account_id = var.account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.this.id
}

#==============================================================================
# ZERO TRUST ORGANIZATION
#==============================================================================

resource "cloudflare_zero_trust_organization" "this" {
  account_id                = var.account_id
  name                      = var.access_team_name
  auth_domain               = "${var.access_team_name}.cloudflareaccess.com"
  auto_redirect_to_identity = true
  deny_unmatched_requests   = true
  session_duration          = var.access_session_duration
}

#==============================================================================
# PUBLIC DNS
#==============================================================================

resource "cloudflare_dns_record" "this" {
  for_each = var.routes

  zone_id = var.zone_id
  name    = each.value.hostname
  type    = "CNAME"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.this.id}.cfargotunnel.com"
  proxied = true
  ttl     = 1
}

#==============================================================================
# BROWSER IDENTITY GATE
#==============================================================================

resource "cloudflare_zero_trust_access_identity_provider" "one_time_pin" {
  account_id = var.account_id
  name       = "Email one-time PIN"
  type       = "onetimepin"
  config     = {}

  depends_on = [cloudflare_zero_trust_organization.this]
}

resource "cloudflare_zero_trust_access_policy" "authenticated_users" {
  account_id       = var.account_id
  name             = "Authenticated tool users"
  decision         = "allow"
  session_duration = var.access_session_duration

  include = [
    for email in sort(tolist(var.allowed_emails)) : {
      email = {
        email = email
      }
    }
  ]

  depends_on = [cloudflare_zero_trust_organization.this]
}

resource "cloudflare_zero_trust_access_application" "this" {
  for_each = var.routes

  account_id                 = var.account_id
  name                       = each.key
  type                       = "self_hosted"
  domain                     = each.value.hostname
  allowed_idps               = [cloudflare_zero_trust_access_identity_provider.one_time_pin.id]
  auto_redirect_to_identity  = true
  http_only_cookie_attribute = true
  same_site_cookie_attribute = "lax"
  session_duration           = var.access_session_duration

  policies = [
    {
      id         = cloudflare_zero_trust_access_policy.authenticated_users.id
      precedence = 1
    }
  ]
}