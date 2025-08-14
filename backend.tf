terraform {
  backend "s3" {
    bucket         = "tf-state-eks101"
    key            = "terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "tf-eks-table"
    encrypt        = true
  }
}