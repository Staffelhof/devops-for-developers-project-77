resource "yandex_cm_certificate" "terra_cert" {
  name          = "terra-staff-letsencrypt"

  self_managed {
    certificate = file(var.tls_fullchain_pem_path)
    private_key = file(var.tls_privkey_pem_path)
  }
}