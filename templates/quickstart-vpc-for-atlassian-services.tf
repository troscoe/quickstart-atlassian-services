module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = var.VPCCIDR

  azs             = var.AvailabilityZones[var.region]
  private_subnets = var.PrivateSubnetCIDRs
  public_subnets  = var.PrivateSubnetCIDRs

  enable_nat_gateway = true
  enable_vpn_gateway = true
}
