terraform {
  backend "remote" {
    # Leave this empty
    # Partially configured backend
    # Will be used for validation via CI/CD
  }
}

module "id" {
  source = "../"
  ami_id  = var.test_id
}

output  "id" {
  value = module.id.server_id
}

