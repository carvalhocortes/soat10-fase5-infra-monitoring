# Grafana em EC2 com CloudWatch

Provisiona uma instância EC2 (Amazon Linux 2023) que sobe Grafana via Docker, provisiona datasources (CloudWatch) e importa um dashboard simples de Lambda. Instala e inicia também o CloudWatch Agent (métricas e logs).

Principais componentes:
- EC2 com user-data em `templates/userdata_grafana.sh.tmpl`
- IAM Role com permissões para CloudWatch/Logs
- CloudWatch Agent com config em `templates/cloudwatch-agent-config.json.tmpl`
- Security Group: SSH(22) e Grafana(3000)

Variáveis importantes (veja `variables.tf`):
- grafana_admin_password (defina no `terraform.tfvars` em produção)
- cloudwatch_uid (UID do datasource usado nos dashboards)
- cwagent_metrics_namespace

Como aplicar:
1. Ajuste `terraform.tfvars` (por exemplo: chave SSH `key_name` e `grafana_admin_password`).
2. Execute:

	terraform init
	terraform apply -auto-approve

3. Saída mostrará `grafana_url`. Acesse com admin / senha definida.

Notas:
- O datasource CloudWatch usa as credenciais da IAM Role da EC2 (authType=default).
- O dashboard exemplo está em `dashboards/aws-lambda.json.tmpl` e é carregado via provisioning.
- Porta 3000 liberada no SG. Restrinja o CIDR conforme necessário.
