data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet" "first" {
  id = data.aws_subnets.default.ids[0]
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  # Use Amazon Linux 2 for broad compatibility with Docker via amazon-linux-extras
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_security_group" "ec2" {
  name        = "basic-ec2-sg"
  description = "Allow SSH and 3000 from anywhere; allow all egress"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

locals {
  # Only embed the AWS Lambda dashboard to minimize user_data size
  dashboards_b64_json = jsonencode({
    "aws-lambda.json.tmpl" = base64encode(file("${path.module}/dashboards/aws-lambda.json.tmpl"))
  })

  userdata = templatefile("${path.module}/templates/userdata_grafana.sh.tmpl", {
    grafana_admin_password = var.grafana_admin_password
    cloudwatch_uid         = var.cloudwatch_uid
    aws_region             = var.AWS_REGION
    cwagent_config = templatefile("${path.module}/templates/cloudwatch-agent-config.json.tmpl", {
      region            = var.AWS_REGION
      metrics_namespace = var.cwagent_metrics_namespace
    })
    dashboards_b64_json = local.dashboards_b64_json
  })
}

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnet.first.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = var.key_name

  iam_instance_profile = aws_iam_instance_profile.grafana.name
  user_data_base64     = base64gzip(local.userdata)

  tags = {
    Name = "Grafana"
  }
}
