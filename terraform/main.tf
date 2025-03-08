
module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = var.vpc_cidr
  subnet_cidr       = var.subnet_cidr
  availability_zone = var.availability_zone
}

module "ec2" {
  source          = "./modules/ec2"
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.subnet_id
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.kubernetes.key_name
}

module "load_balancer" {
  source   = "./modules/load-balancer"
  vpc_id   = module.vpc.vpc_id
  subnet_id = [module.vpc.subnet_id]  # 轉換為 list
}

resource "aws_key_pair" "kubernetes" {
  key_name   = "kubernetes"
  public_key = file("~/.ssh/kubernetes.pub")
}


