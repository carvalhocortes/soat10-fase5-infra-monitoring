locals {
  dashboards = {
    lambda = {
      template = "aws-lambda.json.tpl"
      title    = "AWS Lambda"
    }
    ec2 = {
      template = "amazon-ec2.json.tpl"
      title    = "Amazon EC2"
    }
  }
}

resource "local_file" "dashboards" {
  for_each = local.dashboards

  content = replace(
    replace(
      file("${path.module}/templates/${each.value.template}"),
      "\"uid\": \"$datasource\"",
      "\"uid\": \"cloudwatch-default\""
    ),
    "$datasource",
    "cloudwatch-default"
  )

  filename = "${path.module}/.build/${each.key}-dashboard.json"
}

resource "local_file" "dashboard_provisioning" {
  content = yamlencode({
    apiVersion = 1
    providers = [
      {
        name                  = "default"
        type                  = "file"
        disableDeletion       = false
        updateIntervalSeconds = 10
        allowUiUpdates        = true
        options = {
          path = "/etc/grafana/dashboards"
        }
      }
    ]
  })

  filename = "${path.module}/.build/dashboard-provider.yml"
}

resource "null_resource" "copy_dashboards" {
  for_each = local_file.dashboards

  depends_on = [null_resource.copy_datasource_config]

  connection {
    type        = "ssh"
    host        = aws_instance.grafana.public_ip
    user        = "ubuntu"
    private_key = tls_private_key.grafana_key.private_key_pem
  }

  provisioner "file" {
    source      = each.value.filename
    destination = "/tmp/${basename(each.value.filename)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /etc/grafana/dashboards",
      "sudo mv /tmp/${basename(each.value.filename)} /etc/grafana/dashboards/",
      "sudo chown -R root:grafana /etc/grafana/dashboards/",
      "sudo chmod -R 640 /etc/grafana/dashboards/*"
    ]
  }

  triggers = {
    dashboard_json = each.value.content
  }
}

resource "null_resource" "copy_dashboard_provider_config" {
  depends_on = [null_resource.copy_dashboards]

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

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/dashboard-provider.yml /etc/grafana/provisioning/dashboards/",
      "sudo chown -R root:grafana /etc/grafana/provisioning/dashboards/",
      "sudo chmod -R 640 /etc/grafana/provisioning/dashboards/*",
      "sudo systemctl restart grafana-server",
      "sleep 15"
    ]
  }

  triggers = {
    dashboard_config = local_file.dashboard_provisioning.content
    dashboards_hash  = join(",", [for k, v in local_file.dashboards : v.content])
  }
}
