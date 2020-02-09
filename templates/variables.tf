variable "StackName" {
  type = string
}
variable "region" {
  type = string
  default = "us-west-2"
}
variable "AccessCIDR" {
  type = string
}
variable "ExportPrefix" {
  type = string
  default = "ATL-"
}
variable "KeyPairName" {
  type = string
}
variable "NATInstanceType" {
  type = string
  default = "t3.small"
}
variable "AvailabilityZones" {
  type    = map
  default = {
    "us-east-1" = ["us-east-1a", "us-east-1b"]
    "us-east-2" = ["us-east-2a", "us-east-2b"]
    "us-west-1" = ["us-west-1a", "us-west-1b"]
    "us-west-2" = ["us-west-2a", "us-west-2b"]
    "ap-east-1" = ["ap-east-1a", "ap-east-1b"]
    "ap-south-1" = ["ap-south-1a", "ap-south-1b"]
    "ap-northeast-1" = ["ap-northeast-1a", "ap-northeast-1b"]
    "ap-northeast-2" = ["ap-northeast-2a", "ap-northeast-2b"]
    "ap-southeast-1" = ["ap-southeast-1a", "ap-southeast-1b"]
    "ap-southeast-2" = ["ap-southeast-2a", "ap-southeast-2b"]
    "ca-central-1" = ["ca-central-1a", "ca-central-1b"]
    "eu-central-1" = ["eu-central-1a", "eu-central-1b"]
    "eu-west-1" = ["eu-west-1a", "eu-west-1b"]
    "eu-west-2" = ["eu-west-2a", "eu-west-2b"]
    "eu-west-3" = ["eu-west-3a", "eu-west-3b"]
    "eu-north-1" = ["eu-north-1a", "eu-north-1b"]
    "me-south-1" = ["me-south-1a", "me-south-1b"]
    "sa-east-1" = ["sa-east-1a", "sa-east-1b"]
  }
}
variable "PrivateSubnetCIDRs" {
  type    = list(string)
  default = ["10.0.0.0/19", "10.0.32.0/19"]
}
variable "PublicSubnetCIDRs" {
  type    = list(string)
  default = ["10.0.128.0/20", "10.0.144.0/20"]
}
variable "VPCCIDR" {
  type = string
  default = "10.0.0.0/16"
}
