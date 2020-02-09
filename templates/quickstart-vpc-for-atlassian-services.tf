provider "aws" {
  region  = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.StackName
  cidr = var.VPCCIDR

  azs             = ["ca-central-1a", "ca-central-1b"]
  private_subnets = var.PrivateSubnetCIDRs
  public_subnets  = var.PrivateSubnetCIDRs
  
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true
}
