resource "local_file" "cloudwatch_datasource" {
  content = templatefile("${path.module}/templates/datasource-cloudwatch.yml.tpl", {
    aws_region = var.aws_region
  })

  filename = "${path.module}/.build/datasource-cloudwatch.yml"
}

resource "null_resource" "copy_datasource_config" {
  depends_on = [aws_instance.grafana, time_sleep.wait_for_grafana]

  connection {
    type        = "ssh"
    host        = aws_instance.grafana.public_ip
    user        = "ubuntu"
    private_key = tls_private_key.grafana_key.private_key_pem
  }

  provisioner "file" {
    source      = local_file.cloudwatch_datasource.filename
    destination = "/tmp/cloudwatch.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/cloudwatch.yml /etc/grafana/provisioning/datasources/",
      "sudo chown root:grafana /etc/grafana/provisioning/datasources/cloudwatch.yml",
      "sudo chmod 640 /etc/grafana/provisioning/datasources/cloudwatch.yml",
      "sudo systemctl restart grafana-server",
      "sleep 10"
    ]
  }

  triggers = {
    datasource_config = local_file.cloudwatch_datasource.content
  }
}
