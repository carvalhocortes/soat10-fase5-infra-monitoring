#!/bin/bash

# Log all output
exec > >(tee /var/log/user-data.log) 2>&1

# Update system
apt-get update
apt-get upgrade -y

# Install required packages
apt-get install -y software-properties-common wget curl apt-transport-https

# Add Grafana GPG key and repository
wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | tee -a /etc/apt/sources.list.d/grafana.list

# Update package list and install Grafana
apt-get update
apt-get install -y grafana

# Configure Grafana
cat > /etc/grafana/grafana.ini << EOF
[server]
http_port = ${grafana_port}
domain = localhost

[security]
admin_user = ${grafana_admin_user}
admin_password = ${grafana_admin_password}

[auth.anonymous]
enabled = false

[dashboards]
default_home_dashboard_path = ""

[log]
mode = file
level = info

[paths]
data = /var/lib/grafana
logs = /var/log/grafana
plugins = /var/lib/grafana/plugins
provisioning = /etc/grafana/provisioning
EOF

# Create provisioning directories
mkdir -p /etc/grafana/provisioning/datasources
mkdir -p /etc/grafana/provisioning/dashboards

# Enable and start Grafana
systemctl daemon-reload
systemctl enable grafana-server
systemctl start grafana-server

# Wait for Grafana to start
sleep 30

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
apt-get install -y unzip
unzip awscliv2.zip
./aws/install
rm -rf aws/ awscliv2.zip

# Configure AWS CLI to use instance credentials
export AWS_DEFAULT_REGION=${aws_region}

# Log completion
echo "Grafana installation completed at $(date)" >> /var/log/user-data.log
echo "Grafana should be accessible at http://$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4):${grafana_port}" >> /var/log/user-data.log
