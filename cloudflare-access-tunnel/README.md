# Cloudflare Access Tunnel Module

Creates a remotely managed Cloudflare Tunnel, proxied DNS records, and Cloudflare Access applications for browser-accessible services. Each configured hostname is protected by an email one-time PIN policy before traffic can reach the tunnel route.

## Example

```hcl
module "cloudflare_access_tunnel" {
  source = "git::https://github.com/bharathadigopula/terraform-oci-modules.git//cloudflare-access-tunnel?ref=v0.10.1"

  account_id              = var.cloudflare_account_id
  zone_id                 = data.cloudflare_zone.this.id
  zone_name               = "bharathcloudops.com"
  tunnel_name             = "bharathcloudops-prd-hyd-tools"
  access_team_name        = "bharathcloudops"
  access_session_duration = "12h"
  allowed_emails          = ["operator@example.com"]

  routes = {
    gateway = {
      hostname = "gateway.bharathcloudops.com"
      service  = "http_status:200"
    }
  }
}
```

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---:|---|---|
| `account_id` | `string` | Yes | None | Cloudflare account that owns the tunnel and Access resources |
| `zone_id` | `string` | Yes | None | Cloudflare zone that owns the public DNS records |
| `zone_name` | `string` | Yes | None | Lowercase DNS zone used by every route hostname |
| `tunnel_name` | `string` | Yes | None | Name of the remotely managed tunnel |
| `access_team_name` | `string` | Yes | None | Team name used for the `cloudflareaccess.com` authentication domain |
| `allowed_emails` | `set(string)` | Yes | None | Lowercase email addresses permitted by the reusable Access policy |
| `routes` | `map(object)` | Yes | None | Route names mapped to a hostname and an `http://`, `https://`, or `http_status:` service |
| `access_session_duration` | `string` | No | `12h` | Access organisation, application, and policy session duration |

Every route hostname must be a subdomain of `zone_name`. The module adds a final `http_status:404` catch-all rule after the configured routes.

## Managed Resources

For each deployment, the module manages:

- One remotely managed Cloudflare Tunnel and its ingress configuration.
- One proxied CNAME per route, targeting `<tunnel-id>.cfargotunnel.com`.
- The Cloudflare Zero Trust organisation and email one-time PIN identity provider.
- One reusable allow policy containing only `allowed_emails`.
- One self-hosted Access application per route.

Access application cookies remain `HttpOnly` and use `SameSite=Lax`. `Lax` permits the top-level redirect from the Cloudflare Access authentication domain back to the protected hostname; `Strict` can cause an authentication redirect loop.

## Outputs

| Name | Sensitive | Description |
|---|---:|---|
| `tunnel_id` | No | Identifier of the remotely managed tunnel |
| `tunnel_token` | Yes | Connector token consumed by `cloudflared` |
| `hostnames` | No | Sorted hostnames protected by Cloudflare Access |

Store `tunnel_token` in a secret manager and pass it to the connector only at deployment time. Do not write it to configuration files, workflow inputs, or logs.

## Requirements

- Terraform `>= 1.5.0, < 2.0.0`
- Cloudflare provider `5.24.0`
- An active Cloudflare zone
- Cloudflare Zero Trust enabled for the account
- An API token with Tunnel, Access, organisation, identity provider, and DNS permissions

## Validation

```shell
terraform fmt -check
terraform init -backend=false
terraform validate
```
