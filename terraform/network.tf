resource "yandex_vpc_network" "terra-network" {
  name            = "terra-network"
  folder_id       = var.yc_folder_id
}

resource "yandex_vpc_subnet" "terra-subnet" {
  name            = "terra-subnet"
  zone            = var.yc_zone
  network_id      = yandex_vpc_network.terra-network.id
  v4_cidr_blocks  = ["192.168.0.0/24"]
  folder_id       = var.yc_folder_id
}

resource "yandex_vpc_address" "terra-staff-ip" {
  name = "terra-staff-ip"

  external_ipv4_address {
    zone_id = var.yc_zone
  }
}