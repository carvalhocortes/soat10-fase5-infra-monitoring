output "grafana_public_ip" {
  description = "Public IP address of the Grafana server"
  value       = aws_instance.grafana.public_ip
}

output "grafana_url" {
  description = "URL to access Grafana web interface"
  value       = "http://${aws_instance.grafana.public_ip}:${var.grafana_port}"
}

output "grafana_credentials" {
  description = "Grafana login credentials"
  value = {
    username = var.GRAFANA_ADMIN_USER
    password = var.GRAFANA_ADMIN_PASSWORD
  }
  sensitive = true
}

output "ssh_connection" {
  description = "SSH connection command to access the Grafana server"
  value       = "ssh -i grafana-key.pem ubuntu@${aws_instance.grafana.public_ip}"
}

output "ssh_key_location" {
  description = "Location of the generated SSH private key"
  value       = "${path.module}/grafana-key.pem"
}

output "aws_region" {
  description = "AWS region where resources are deployed"
  value       = var.aws_region
}

output "instance_id" {
  description = "EC2 instance ID of the Grafana server"
  value       = aws_instance.grafana.id
}

output "security_group_id" {
  description = "ID of the security group attached to Grafana instance"
  value       = aws_security_group.grafana_sg.id
}

output "iam_role_arn" {
  description = "ARN of the IAM role attached to the Grafana instance"
  value       = aws_iam_role.grafana_role.arn
}
