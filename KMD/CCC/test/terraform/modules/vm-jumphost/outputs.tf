output "ssh-key-pem" {
  sensitive = true
  value     = tls_private_key.jumphost-ssh-key.public_key_pem
}
