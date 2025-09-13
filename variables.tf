variable "AWS_REGION" {
  description = "Região AWS"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "EC2 key pair name for SSH (optional)"
  type        = string
  default     = null
}

variable "grafana_admin_password" {
  description = "Grafana admin password (set a strong value in tfvars for prod)"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "cloudwatch_uid" {
  description = "Grafana CloudWatch datasource UID referenced by dashboards"
  type        = string
  default     = "cloudwatch-default"
}

variable "cwagent_metrics_namespace" {
  description = "CloudWatch Agent metrics namespace"
  type        = string
  default     = "EC2/GrafanaHost"
}
