module "AutoScaling" {
  source            = "./modules/autoscaling"
  ami-web           = var.ami-web
  ami-bastion       = var.ami-bastion
  ami-nginx         = var.ami-nginx
  desired_capacity  = 1
  min_size          = 1
  max_size          = 1
  web-sg            = [module.security.web-sg]
  bastion-sg        = [module.security.bastion-sg]
  nginx-sg          = [module.security.nginx-sg]
  application-alb-tgt = module.ALB.application-tgt
  nginx-alb-tgt     = module.ALB.nginx-tgt
  instance_profile  = module.VPC.instance_profile
  public_subnets    = [module.VPC.public_subnets-1, module.VPC.public_subnets-2]
  private_subnets   = [module.VPC.private_subnets-1, module.VPC.private_subnets-2]
  keypair           = var.keypair
}

module "ALB" {
  source             = "./modules/alb"
  name1               = "RCR-ext-alb"
  name2               = "RCR-int-alb"
  vpc_id             = module.VPC.vpc_id
  public-sg          = module.security.ALB-sg
  private-sg         = module.security.IALB-sg
  public-sbn-1       = module.VPC.public_subnets-1
  public-sbn-2       = module.VPC.public_subnets-2
  private-sbn-1      = module.VPC.private_subnets-1
  private-sbn-2      = module.VPC.private_subnets-2
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.VPC.vpc_id
}

module "VPC" {
  source                              = "./modules/vpc"
  region                              = var.region
  vpc_cidr                            = var.vpc_cidr
  enable_dns_support                  = var.enable_dns_support
  enable_dns_hostnames                = var.enable_dns_hostnames
  preferred_number_of_public_subnets  = var.preferred_number_of_public_subnets
  preferred_number_of_private_subnets = var.preferred_number_of_private_subnets
  public_subnets                      = [for i in range(2, 5, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  private_subnets = [for i in range(1, 8, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
}


