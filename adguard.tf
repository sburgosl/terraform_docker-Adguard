# Docker AdGuard Home

resource "docker_image" "adguardhome" {
  name         = "adguard/adguardhome:${var.adguard_version}"
  keep_locally = true
}

resource "docker_container" "adguardhome" {
  image     = docker_image.adguardhome.latest
  name      = "adguard"
  hostname  = "rpi_adguard"
  restart   = "unless-stopped"

  # HTTP
  dynamic "ports" {
    for_each = var.use_traefik ? [] : [1]
    content {
      internal = var.int_http_ui_port
      external = var.ext_http_ui_port
    }
  }
  # HTTPS
  dynamic "ports" {
    for_each = var.use_https && !var.use_traefik ? [1] : []
    content {
      internal = 443
      external = 443 
    }
  }
  
  # DNS
  ports {
    internal = 53
    external = 53
    protocol = "tcp"
  }
  ports {
    internal = 53
    external = 53
    protocol = "udp"  
  }
  dynamic "ports" {
    for_each = var.use_https ? [1] : []
    content {
      internal = 853
      external = 853
    }
  }

  # DHCP
  dynamic "ports" {
    for_each = var.use_dhcp ? [1] : []
    content {
      internal = 67
      external = 67
      protocol = "udp"
    }
  }
  dynamic "ports" {
    for_each = var.use_dhcp ? [1] : []
    content {
      internal = 68
      external = 68
      protocol = "tcp"
    }
  }
  dynamic "ports" {
    for_each = var.use_dhcp ? [1] : []
    content {
      internal = 68
      external = 68
      protocol = "udp"
    }
  }

  # First time config
  dynamic "ports" {
    for_each = var.fist_config ? [1] : []
    content {
      internal = 3000
      external = 3000
    }
  }

  # Bind mounts
  volumes { 
    host_path      = var.adguard_workdir
    container_path = "/opt/adguardhome/work"
  }
  volumes {
    host_path      = var.adguard_confdir
    container_path = "/opt/adguardhome/conf"
  }

  # Traefik
  dynamic "labels" {
    for_each = var.use_traefik ? [1] : []
    content {
      label = "traefik.enable"
      value = "true"
    }
  }
  dynamic "labels" {
    for_each = var.use_traefik ? [1] : []
    content {
      label = "traefik.http.routers.adguard.rule"
      value = "Host(`adguard.${var.domain_name}`)"
    }
  }
  dynamic "labels" {
    for_each = var.use_traefik ? [1] : []
    content {
      label = "traefik.http.routers.adguard.entrypoints"
      value = var.use_https ? "websecure" : "web"
    }
  }
  dynamic "labels" {
    for_each = var.use_traefik ? [1] : []
    content {
      label = "traefik.http.services.adguard.loadbalancer.server.port"
      value = var.use_https ? "443" : var.int_http_ui_port
    }
  }

}