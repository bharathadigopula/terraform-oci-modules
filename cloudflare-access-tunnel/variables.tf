#==============================================================================
# CLOUDFLARE ACCOUNT AND ZONE
#==============================================================================

variable "account_id" {
  description = "Cloudflare account identifier that owns the tunnel and Access resources."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-f]{32}$", var.account_id))
    error_message = "account_id must be a 32-character lowercase hexadecimal Cloudflare account identifier."
  }
}

variable "zone_id" {
  description = "Cloudflare zone identifier that owns the public DNS records."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-f]{32}$", var.zone_id))
    error_message = "zone_id must be a 32-character lowercase hexadecimal Cloudflare zone identifier."
  }
}

variable "zone_name" {
  description = "Cloudflare DNS zone used for public tool hostnames."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?(?:\\.[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?)+$", var.zone_name))
    error_message = "zone_name must be a lowercase fully qualified domain name."
  }
}

#==============================================================================
# TUNNEL AND ACCESS CONFIGURATION
#==============================================================================

variable "tunnel_name" {
  description = "Human-readable name assigned to the Cloudflare tunnel."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,62}[a-z0-9]$", var.tunnel_name))
    error_message = "tunnel_name must contain 3-64 lowercase letters, numbers, or hyphens."
  }
}

variable "access_team_name" {
  description = "Unique Cloudflare Access team name used in the authentication domain."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$", var.access_team_name))
    error_message = "access_team_name must contain 3-63 lowercase letters, numbers, or hyphens."
  }
}

variable "allowed_emails" {
  description = "Email addresses permitted to authenticate through Cloudflare Access."
  type        = set(string)

  validation {
    condition = length(var.allowed_emails) > 0 && alltrue([
      for email in var.allowed_emails :
      email == lower(trimspace(email)) && can(regex("^[^@[:space:]]+@[^@[:space:]]+\\.[^@[:space:]]+$", email))
    ])
    error_message = "allowed_emails must contain at least one valid lowercase email address."
  }
}

variable "routes" {
  description = "Public hostnames and private origin services routed through the tunnel."
  type = map(object({
    hostname = string
    service  = string
  }))

  validation {
    condition     = length(var.routes) > 0
    error_message = "routes must contain at least one hostname and origin service."
  }

  validation {
    condition = alltrue([
      for route in values(var.routes) :
      endswith(route.hostname, ".${var.zone_name}") &&
      can(regex("^(https?://|http_status:)", route.service))
    ])
    error_message = "Each hostname must belong to zone_name and each service must use http://, https://, or http_status:."
  }
}

variable "access_session_duration" {
  description = "Duration of authenticated Cloudflare Access sessions."
  type        = string
  default     = "12h"

  validation {
    condition     = can(regex("^[1-9][0-9]*(m|h)$", var.access_session_duration))
    error_message = "access_session_duration must be expressed in whole minutes or hours, such as 30m or 12h."
  }
}