provider "aws" {
  region  = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.StackName
  cidr = var.VPCCIDR

  azs             = var.AvailabilityZones[var.region]
  private_subnets = var.PrivateSubnetCIDRs
  public_subnets  = var.PrivateSubnetCIDRs
}
