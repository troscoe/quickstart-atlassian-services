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

module "bastion" {
  source = "terraform-aws-modules/bastion/aws"
  bucket_name = join("-", [var.ExportPrefix, "bastion-bucket", module.vpc.id])
  region = var.region
  vpc_id = module.vpc.id
  create_dns_record = "false"
  is_lb_private = "false"
  bastion_host_key_pair = aws_key_pair.generated_key.key_name
  elb_subnets = var.PublicSubnetCIDRs
  auto_scaling_group_subnets = var.PublicSubnetCIDRs
}

resource "aws_s3_bucket" "bastion" {
  bucket = join("-", [var.ExportPrefix, "bastion-bucket", module.vpc.id])
  acl    = "private"
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = join("-", [var.ExportPrefix, "bastion-key", module.vpc.id])
  public_key = "tls_private_key.example.public_key_openssh
}
