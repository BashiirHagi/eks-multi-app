module "vpc" {
  source             = "./modules/vpc"
  aws_region         = var.aws_region
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  environment        = var.environment
  availability_zones = var.availability_zones
  tags               = var.tags
  s3_logging_bucket  = var.s3_logging_bucket
  vpc_cidr           = var.vpc_cidr
}