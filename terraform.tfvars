aws_region        = "eu-west-2"
environment       = "development"
s3_logging_bucket = "eks-vpc-logs-bucket-dev"

vpc_cidr           = "192.168.0.0/16"
availability_zones = ["eu-west-2b", "eu-west-2c"]
public_subnets     = [ "192.168.2.0/24", "192.168.3.0/24"]
private_subnets    = [ "192.168.20.0/24", "192.168.30.0/24"]

tags = {
  environment = "development"
  project     = "eks-multi-app"
}