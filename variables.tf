# Docker AdGuard Variables file

variable "adguard_version" {
  type        = string
  default     = "latest"
  description = "Docker Image Tag"
}

variable "fist_config" {
  type        = bool
  default     = false
  description = "Expose tcp/3000 for first config"
}

variable "use_https" {
  type        = bool
  default     = false
  description = "Enable HTTPS port for Web UI"
}

variable "use_dhcp" {
  type        = bool
  default     = false
  description = "Enable Adguard DHCP server"
}

variable "use_traefik" {
  type        = bool
  default     = false
  description = "Enable Adguard DHCP server"
}

variable "ext_http_ui_port" {
  type        = number
  default     = 80
  description = "Host TCP Port Web UI"
}

variable "int_http_ui_port" {
  type        = number
  default     = 80
  description = "Container TCP Port Web UI. Must be the same as the configured in Adguard Config"
}

variable "adguard_workdir" {
  type        = string
  default     = "/opt/adguard/workdir"
  description = "AdGuard WorkDir Folder"
}

variable "adguard_confdir" {
  type        = string
  default     = "/opt/adguard/confdir"
  description = "AdGuard ConfDir Folder"
}