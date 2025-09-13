resource "local_file" "lambda_dashboard" {
  content = replace(
    replace(
      file("${path.module}/dashboards/aws-lambda.json.tmpl"),
      "\"uid\": \"$datasource\"",
      "\"uid\": \"cloudwatch-default\""
    ),
    "$datasource",
    "cloudwatch-default"
  )

  filename = "${path.module}/lambda-dashboard.json"
}

resource "local_file" "dashboard_provisioning" {
  content = yamlencode({
    apiVersion = 1
    providers = [
      {
        name = "default"
        type = "file"
        disableDeletion = false
        updateIntervalSeconds = 10
        allowUiUpdates = true
        options = {
          path = "/etc/grafana/dashboards"
        }
      }
    ]
  })

  filename = "${path.module}/dashboard-provider.yml"
}

resource "null_resource" "copy_dashboard_config" {
  depends_on = [null_resource.copy_datasource_config, local_file.lambda_dashboard]

  connection {
    type        = "ssh"
    host        = aws_instance.grafana.public_ip
    user        = "ubuntu"
    private_key = tls_private_key.grafana_key.private_key_pem
  }

  provisioner "file" {
    source      = local_file.dashboard_provisioning.filename
    destination = "/tmp/dashboard-provider.yml"
  }

  provisioner "file" {
    source      = local_file.lambda_dashboard.filename
    destination = "/tmp/lambda-dashboard.json"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /etc/grafana/dashboards",
      "sudo mv /tmp/dashboard-provider.yml /etc/grafana/provisioning/dashboards/",
      "sudo mv /tmp/lambda-dashboard.json /etc/grafana/dashboards/",
      "sudo chown -R root:grafana /etc/grafana/provisioning/dashboards/",
      "sudo chown -R root:grafana /etc/grafana/dashboards/",
      "sudo chmod -R 640 /etc/grafana/provisioning/dashboards/*",
      "sudo chmod -R 640 /etc/grafana/dashboards/*",
      "sudo systemctl restart grafana-server",
      "sleep 15"
    ]
  }

  triggers = {
    dashboard_config = local_file.dashboard_provisioning.content
    dashboard_json   = local_file.lambda_dashboard.content
  }
}
