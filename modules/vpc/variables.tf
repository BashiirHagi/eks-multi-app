variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "eu-west-1"
}
variable "tags" {
  description = "A map of tags to add to all the resources"
  type        = map(string)
  default = {
    environment = "Development"
  }
}
variable "environment" {
  description = "The environment the VPC will be provisioned in"
  type        = string
  default     = "development"
}
variable "s3_logging_bucket" {
  description = "S3 bucket to store VPC logs"
  type        = string
}
####### VPC######################
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "availability_zones" {
  description = "The availability zones to be used"
  type        = list(string)
}
variable "public_subnets" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}
variable "private_subnets" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
}
