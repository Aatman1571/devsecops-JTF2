provider "local" {}

resource "local_file" "infra" {
  content  = "Infrastructure provisioned securely"
  filename = "${path.module}/infra.txt"
}

resource "local_file" "secure_config" {
  content  = "Simulated secure settings like IAM and Security Groups"
  filename = "${path.module}/secure_config.txt"
}
