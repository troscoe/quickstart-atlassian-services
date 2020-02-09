provider "aws" {
  region  = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = join("-", [var.ExportPrefix, "VPC"])
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
  source = "terraform-aws-modules/ec2-instance/aws"

  instance_count = 1

  name          = "Bastion for Atlassian Product VPC"
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnets
  vpc_security_group_ids      = [module.security_group.this_security_group_id]
  associate_public_ip_address = true
}
  
module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"

  name = "SSH access"
  description = "Security group allowing SSH access"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-22-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}
  
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}
