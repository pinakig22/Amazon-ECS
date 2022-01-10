## Region
variable "region" {
  description = "The AWS region your resources will be deployed"
}

# Availability zones
variable "az" {
  description = "Availability Zones within a region"
  type        = list(string)
}
## VPC CIDR
variable "vpc_cidr" {
  description = "The VPC Network address"
}

## Subnets
variable "private_subnet" {
  description = "Private subnet IP CIDRs"
  type        = list(string)
}

variable "public_subnet" {
  description = "Public subnet IP CIDRs"
  type        = list(string)
}