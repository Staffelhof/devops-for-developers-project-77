resource "yandex_staff_target_group" "terra-tg" {
  name           = "terra-tg"

  target {
    subnet_id    = yandex_vpc_subnet.terra-subnet.id
    ip_address = yandex_compute_instance.app-server-1.network_interface.0.ip_address
  }

  target {
    subnet_id    = yandex_vpc_subnet.terra-subnet.id
    ip_address = yandex_compute_instance.app-server-2.network_interface.0.ip_address
  }
}

resource "yandex_staff_backend_group" "terra-bg" {
  name = "terra-bg"

  http_backend {
    name                   = "terra-backend"
    weight                 = 1
    port                   = 3000
    target_group_ids       = [yandex_staff_target_group.terra-tg.id]
    healthcheck {
      timeout              = "1s"
      interval             = "1s"
      healthy_threshold    = 1
      unhealthy_threshold  = 1
      healthcheck_port     = 3000
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_staff_http_router" "terra-router" {
  name          = "terra-router"
}

resource "yandex_staff_virtual_host" "terra-host" {
  name                    = "terra-host"
  http_router_id          = yandex_staff_http_router.terra-router.id

  route {
    name                  = "terra-route"
    http_route {
      http_match  {
        path {
          prefix          = "/"
	      }
      }
      http_route_action {
        backend_group_id  = yandex_staff_backend_group.terra-bg.id
        timeout           = "60s"
	      auto_host_rewrite =  false
      }
    }
  }

  authority = ["terra.allegrohub.ru"]
}

resource "yandex_staff_load_balancer" "terra-staff" {
  name        = "terra-staff"
  network_id  = yandex_vpc_network.terra-network.id
  security_group_ids = [yandex_vpc_security_group.terra-sg-balancer.id]

  allocation_policy {
    location {
      zone_id   = var.yc_zone
      subnet_id = yandex_vpc_subnet.terra-subnet.id
    }
  }

  listener {
    name = "terra-listener-http"
    endpoint {
      address {
        external_ipv4_address {
          address = yandex_vpc_address.terra-staff-ip.external_ipv4_address[0].address
        }
      }
      ports = [80]
    }
    http {
      redirects {
        http_to_https = true
      }
    }
  }

  listener {
    name = "terra-listener-https"
    endpoint {
      address {
        external_ipv4_address {
          address = yandex_vpc_address.terra-staff-ip.external_ipv4_address[0].address
        }
      }
      ports = [443]
    }
    tls {
      default_handler {
        http_handler {
          http_router_id = yandex_staff_http_router.terra-router.id
        }
        certificate_ids = [yandex_cm_certificate.staff_cert.id]
      }
      sni_handler {
        name = "terra-sni"
        server_names = ["terra.allegrohub.ru"]
        handler {
          http_handler {
            http_router_id = yandex_staff_http_router.terra-router.id
          }
          certificate_ids = [yandex_cm_certificate.staff_cert.id]
        }
      }
    }
  }

  log_options {
    disable = true
  }
}