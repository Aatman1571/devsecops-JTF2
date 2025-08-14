provider "local" {}

resource "local_file" "simulate" {
  content  = "Provisioned by Terraform!"
  filename = "${path.module}/infra.txt"
}
