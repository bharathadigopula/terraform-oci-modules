#==============================================================================
# CLOUDFLARE TUNNEL OUTPUTS
#==============================================================================

output "tunnel_id" {
  description = "Identifier of the remotely managed Cloudflare tunnel."
  value       = cloudflare_zero_trust_tunnel_cloudflared.this.id
}

output "tunnel_token" {
  description = "Sensitive connector token used by cloudflared hosts."
  value       = data.cloudflare_zero_trust_tunnel_cloudflared_token.this.token
  sensitive   = true
}

output "hostnames" {
  description = "Public hostnames protected by Cloudflare Access."
  value       = sort([for route in values(var.routes) : route.hostname])
}