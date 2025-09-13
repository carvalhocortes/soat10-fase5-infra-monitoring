resource "tls_private_key" "grafana_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "grafana_private_key" {
  content         = tls_private_key.grafana_key.private_key_pem
  filename        = "${path.module}/grafana-key.pem"
  file_permission = "0400"
}

resource "aws_key_pair" "grafana_key" {
  key_name   = var.key_name
  public_key = tls_private_key.grafana_key.public_key_openssh

  tags = {
    Name = "${var.project_name}-key"
  }
}
