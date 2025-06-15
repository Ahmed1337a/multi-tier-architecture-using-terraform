provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
  alb_sg_id = module.security.alb_sg_id
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  alb_sg_id = module.security.alb_sg_id
}

module "ec2" {
  source = "./modules/ec2"
  vpc_id = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  app_sg_id = module.security.app_sg_id
  user_data = file("scripts/app_setup.sh")
}

module "rds" {
  source = "./modules/rds"
  db_subnets = module.vpc.db_subnets
  db_sg_id = module.security.db_sg_id
}

output "alb_dns" {
  value = module.alb.dns_name
}

output "rds_endpoint" {
  value = module.rds.endpoint
}
