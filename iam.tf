resource "aws_iam_role" "grafana_role" {
  name = "${var.project_name}-grafana-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-grafana-role"
  }
}

resource "aws_iam_role_policy_attachment" "cloudwatch_read_only" {
  role       = aws_iam_role.grafana_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "logs_read_only" {
  role       = aws_iam_role.grafana_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsReadOnlyAccess"
}

resource "aws_iam_role_policy" "grafana_additional_permissions" {
  name = "${var.project_name}-grafana-additional-policy"
  role = aws_iam_role.grafana_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeRegions",
          "ec2:DescribeAvailabilityZones",
          "lambda:ListFunctions",
          "lambda:GetFunction",
          "rds:DescribeDBInstances",
          "tag:GetResources"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "grafana_profile" {
  name = "${var.project_name}-grafana-profile"
  role = aws_iam_role.grafana_role.name

  tags = {
    Name = "${var.project_name}-grafana-profile"
  }
}
