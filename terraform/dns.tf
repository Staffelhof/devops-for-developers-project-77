resource "yandex_dns_zone" "production" {
  name        = "prod-zone"
  description = "Production DNS zone for ${var.domain_name}"
  zone        = "${var.domain_name}."
}

resource "yandex_dns_recordset" "terra_record" {
  zone_id = yandex_dns_zone.prod-zone.id
  name    = "${var.domain_name}."
  type    = "A"
  ttl     = 600
  data    = [yandex_vpc_address.terra-staff-ip.external_ipv4_address[0].address]
}