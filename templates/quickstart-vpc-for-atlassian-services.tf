provider "aws" {
  region  = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = join("", [var.ExportPrefix, "VPC"])
  cidr = var.VPCCIDR

  azs             = var.AvailabilityZones[var.region]
  private_subnets = var.PrivateSubnetCIDRs
  public_subnets  = var.PublicSubnetCIDRs
  
  enable_ipv6 = true
  
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = true
  
  private_dedicated_network_acl = true
}
