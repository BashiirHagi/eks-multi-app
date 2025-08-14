## AWS VPC module
Configuration in this directory creates an AWS VPC network, subnets, NAT gateway, Internet gateway, VPC endpoint and associated resources. 
## Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- An AWS account with appropriate permissions to create AWS VPC resources.
## Usage Example:
The calling module will have separate terraform.tfvars files for each aws environment and region. 
```
Example:
module "vpc" {
  source  = "../vpc/"
  aws_region         = var.aws_region
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  tags               = var.tags
  s3_logging_bucket  = var.s3_logging_bucket
  vpc_cidr           = var.vpc_cidr
}
```
