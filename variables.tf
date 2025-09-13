variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-west-2"
}

variable "instance_type" {
  description = "EC2 instance type for Grafana server"
  type        = string
  default     = "t3.small"
}

variable "grafana_admin_user" {
  description = "Grafana admin username"
  type        = string
}

variable "grafana_admin_password" {
  description = "Grafana admin password"
  type        = string
  sensitive   = true
}

variable "grafana_port" {
  description = "Port for Grafana web interface"
  type        = number
  default     = 3000
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access Grafana and SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "key_name" {
  description = "Name for the AWS Key Pair"
  type        = string
  default     = "grafana-key"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "fiap-fase5-monitoring"
}
