output "ec2_public_ip" {
  value       = aws_instance.ec2.public_ip
  description = "Public IP of the EC2 instance"
}

output "ec2_public_dns" {
  value       = aws_instance.ec2.public_dns
  description = "Public DNS of the EC2 instance"
}

output "grafana_url" {
  value       = "http://${aws_instance.ec2.public_ip}:3000"
  description = "Grafana URL"
}

output "cloudwatch_metrics_namespace" {
  value       = var.cwagent_metrics_namespace
  description = "CloudWatch Agent metrics namespace"
}
