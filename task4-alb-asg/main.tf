# module wiring

module "vpc" {
  source       = "./modules/vpc"
  name_prefix  = var.name_prefix
  region       = var.region
  subnet_count = 2
  vpc_cidr     = "10.0.0.0/16"
}

