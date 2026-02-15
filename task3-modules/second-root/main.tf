module "vpc" {
  source       = "./modules/vpc"
  name_prefix  = "second_root"
  region       = var.region
  subnet_count = 3
  vpc_cidr     = "10.0.1.0/16"
}

module "ec2" {
  source           = "./modules/ec2"
  name_prefix      = "second_root"
  region           = var.region
  vpc_id           = module.vpc.vpc_id
  subnet_id        = module.vpc.public_subnet_id
  instance_type    = "t3.micro"
  assign_public_ip = true
}