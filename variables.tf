variable "AWS_REGION" {
  description = "Região AWS"
  type        = string
  default     = "us-west-2"
}

variable "AWS_ACCOUNT_ID" {
  type    = string
  default = "381492156649"
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

variable "existing_instance_profile_name" {
  description = "Existing IAM instance profile name to attach to EC2 (e.g., LabRole)"
  type        = string
  default     = "LabInstanceProfile"
}

variable "dashboards_s3_bucket" {
  description = "S3 bucket to upload dashboards archive (instance will download at boot)"
  type        = string
  default     = "postech-soat10-fase5"
}

variable "dashboards_s3_key" {
  description = "S3 object key for dashboards archive"
  type        = string
  default     = "grafana/dashboards.zip"
}


