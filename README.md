# FIAP Fase 5 - Infrastructure Monitoring with Grafana

This project deploys a complete monitoring infrastructure using Terraform, featuring:

- AWS EC2 instance running Grafana
- Automated CloudWatch integration
- Pre-configured AWS Lambda monitoring dashboard
- Secure SSH key generation
- IAM roles with minimal required permissions

## Architecture Overview

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   CloudWatch    │────│    Grafana EC2   │────│   Dashboard     │
│   Data Source   │    │   (us-west-2)    │    │   (Lambda)      │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                │
                       ┌────────┴────────┐
                       │   IAM Role      │
                       │ (CloudWatch     │
                       │  Permissions)   │
                       └─────────────────┘
```

## Quick Start

```bash
# Initialize and deploy
terraform init
terraform apply

# Get Grafana URL and credentials
terraform output grafana_url
terraform output grafana_credentials
```

## Infrastructure Components

### 1. Provider Configuration (`provider.tf`)

- **AWS Provider**: Configured for us-west-2 region
- **Required Providers**: TLS, Local, Null, Time for key generation and provisioning
- **Default Tags**: Applied to all resources for organization

### 2. Variables (`variables.tf`)

- **aws_region**: us-west-2 (configurable)
- **instance_type**: t3.small (balanced performance/cost)
- **grafana_admin_user/password**: admin/admin (configurable)
- **Security**: CIDR blocks for access control

### 3. SSH Key Management (`ssh.tf`)

- **Automatic Generation**: 4096-bit RSA key pair created via Terraform
- **Local Storage**: Private key saved as `grafana-key.pem` (permissions: 0400)
- **AWS Integration**: Public key automatically registered as AWS Key Pair

### 4. Security & Permissions (`iam.tf`)

- **IAM Role**: Dedicated role for EC2 instance
- **Managed Policies**:
  - `CloudWatchReadOnlyAccess`
  - `CloudWatchLogsReadOnlyAccess`
- **Custom Policy**: Additional permissions for resource discovery
- **Principle of Least Privilege**: Only necessary permissions granted

### 5. Network & Compute (`ec2.tf`)

- **EC2 Instance**: t3.small running Ubuntu 22.04 LTS
- **Security Group**: Allows SSH (22), HTTP (80), HTTPS (443), Grafana (3000)
- **Public Access**: Instance has public IP for external access
- **Default VPC**: Uses existing default VPC and subnets

### 6. Grafana Installation (`grafana-install.sh`)

- **Automated Setup**: Complete Grafana installation via user_data
- **Configuration**: Pre-configured with admin credentials
- **AWS CLI**: Installed for CloudWatch integration
- **Service Management**: Grafana service enabled and started

### 7. Data Source Configuration (`datasource.tf`)

- **CloudWatch Integration**: Automatic provisioning of CloudWatch data source
- **Default Region**: Configured for us-west-2
- **Authentication**: Uses EC2 instance IAM role credentials
- **Default Data Source**: Set as primary for all dashboards

### 8. Dashboard Setup (`dashboard.tf`)

- **Lambda Dashboard**: Imported from local `dashboards/aws-lambda.json.tpl`
- **Data Source Mapping**: Automatically configured to use CloudWatch
- **Provisioning**: Dashboard automatically available after deployment
- **Metrics Included**: Invocations, errors, throttles, duration per function

## Technical Choices & Rationale

### Security Decisions

1. **IAM Role over Access Keys**: More secure, no credential management needed
2. **Managed Policies**: AWS-maintained, regularly updated security policies
3. **SSH Key Generation**: Automated to ensure unique keys per deployment
4. **Security Groups**: Restrictive by default, configurable via variables

### Infrastructure Decisions

1. **t3.small Instance**: Good balance of performance and cost for Grafana
2. **Default VPC**: Simplifies setup, uses existing network infrastructure
3. **Public IP**: Required for external access to Grafana interface
4. **us-west-2 Region**: Reliable region with good service availability

### Monitoring Decisions

1. **CloudWatch Integration**: Native AWS service, no additional infrastructure
2. **Lambda Focus**: Serverless monitoring is key for modern applications
3. **Provisioned Configuration**: Infrastructure as Code approach for consistency

## Usage Instructions

### 1. Deployment

```bash
# Clone and navigate to project
cd infra-monitoring

# Initialize Terraform
terraform init

# Review planned changes
terraform plan

# Deploy infrastructure
terraform apply
```

### 2. Access Grafana

```bash
# Get access information
terraform output grafana_url
terraform output grafana_credentials

# Example output:
# grafana_url = "http://35.91.31.136:3000"
# grafana_credentials = {
#   "password" = "admin"
#   "username" = "admin"
# }
```

### 3. SSH Access (if needed)

```bash
# Get SSH connection details
terraform output ssh_connection
terraform output ssh_key_location

# SSH to instance
ssh -i grafana-key.pem ubuntu@<public-ip>
```

### 4. Dashboard Access

1. Open Grafana URL in browser
2. Login with credentials: `admin` / `admin`
3. Navigate to Dashboards → AWS Lambda
4. View metrics for any Lambda functions in your account

## File Structure

```
.
├── backend.tf                           # S3 backend configuration (existing)
├── provider.tf                          # AWS provider and version constraints
├── variables.tf                         # Input variables
├── ssh.tf                              # SSH key generation
├── iam.tf                              # IAM roles and policies
├── ec2.tf                              # EC2 instance and security group
├── grafana.tf                          # Grafana-specific resources
├── grafana-install.sh                  # Grafana installation script
├── datasource.tf                       # CloudWatch data source setup
├── datasource-cloudwatch.yml.tpl       # Data source configuration template
├── dashboard.tf                        # Dashboard provisioning
├── outputs.tf                          # Output values
├── dashboards/                         # Dashboard templates
│   └── aws-lambda.json.tpl            # Lambda monitoring dashboard
└── README.md                           # This documentation
```

## Generated Files (after deployment)

```
├── grafana-key.pem                     # SSH private key (chmod 400)
├── datasource-cloudwatch.yml           # Generated data source config
├── lambda-dashboard.json               # Generated dashboard
├── dashboard-provider.yml              # Dashboard provisioning config
└── .terraform/                         # Terraform state and providers
```

## Troubleshooting

### Common Issues

1. **Instance Type Not Available**

   ```bash
   # Update instance type in variables.tf
   variable "instance_type" {
     default = "t3.micro"  # or another available type
   }
   ```

2. **Grafana Not Accessible**

   ```bash
   # Check instance status
   aws ec2 describe-instances --instance-ids $(terraform output -raw instance_id)

   # Check user data logs
   ssh -i grafana-key.pem ubuntu@$(terraform output -raw grafana_public_ip)
   sudo tail -f /var/log/user-data.log
   ```

3. **No Lambda Data**
   - Ensure you have Lambda functions in the us-west-2 region
   - Verify IAM permissions are correctly attached
   - Check CloudWatch data source configuration in Grafana

### Useful Commands

```bash
# Check infrastructure status
terraform show

# Update infrastructure
terraform apply

# Destroy infrastructure
terraform destroy

# View all outputs
terraform output

# SSH to instance
ssh -i grafana-key.pem ubuntu@$(terraform output -raw grafana_public_ip)
```

## Security Considerations

1. **Change Default Credentials**: Update admin password after deployment
2. **Network Access**: Consider restricting `allowed_cidr_blocks` variable
3. **SSH Key**: Keep `grafana-key.pem` secure, rotate regularly
4. **IAM Permissions**: Review and audit IAM policies periodically
5. **Updates**: Keep Grafana and system packages updated

## Cost Optimization

- **Instance Size**: Start with t3.small, scale based on usage
- **Scheduled Shutdown**: Consider stopping instance during non-business hours
- **Spot Instances**: For non-critical environments, consider spot instances
- **Monitoring**: Use AWS Cost Explorer to track spending

## Contributing

1. Follow Infrastructure as Code best practices
2. Test all changes in non-production environment
3. Update documentation for any configuration changes
4. Use semantic versioning for releases

## License

This project is licensed under the terms specified in the LICENSE file.

---

**Deployment Date**: $(date)
**Terraform Version**: $(terraform version | head -n1)
**AWS Region**: us-west-2
**Project**: FIAP Fase 5 - Infrastructure Monitoring
