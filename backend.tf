terraform {
  backend "s3" {
    bucket = "postech-soat10-fase5"
    key    = "github-actions-fiap/infra-monitoring/terraform.tfstate"

    region  = "us-west-2"
    encrypt = true
  }

  required_version = ">= 1.2.0"

}
