output "staff_external_ip" {
  value = yandex_vpc_address.terra-staff-ip.external_ipv4_address[0].address
}

output "server_1_ip" {
  value = yandex_compute_instance.server-1.network_interface.0.nat_ip_address
}

output "server_2_ip" {
  value = yandex_compute_instance.server-2.network_interface.0.nat_ip_address
}

output "postgresql_host" {
  value = yandex_mdb_postgresql_cluster.terradb.host[0].fqdn
}
