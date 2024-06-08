module "vpc" {
  source              = "./modules/vpc"
  dev_vpc_cidr        = var.dev_vpc_cidr
  prod_vpc_cidr       = var.prod_vpc_cidr
  public_subnets_cidr = var.public_subnets_cidr
}

module "aws_security_group" {
  source               = "./modules/SG"
  dev_vpc_id           = module.vpc.dev_vpc_id
  inbount_port_numbers = var.inbount_port_numbers
}

module "dev_docker_server" {
  source                 = "./modules/ec2"
  dev_SG_id              = module.aws_security_group.dev_SG
  dev_public_subnets_ids = module.vpc.dev_public_subnets_ids
}

module "aws_lb" {
  source                 = "./modules/ALB"
  dev_SG_id              = module.aws_security_group.dev_SG
  dev_public_subnets_ids = module.vpc.dev_public_subnets_ids
  dev_vpc_id             = module.vpc.dev_vpc_id
  docker_instances_ids   = module.dev_docker_server.docker-instances
}