## VPC Name
variable vpc_name {
  description = "Name of VPC"
}

## Region
variable "region" {
  description = "The AWS region your resources will be deployed"
}

# Availability zones
variable "az" {
  description = "Availability Zones within a region"
  type        = list(string)
}

## Envrionment
variable env {
  description = "Name of Environment or setup"
}

## ECS EC2 instance type
variable "ec2_instance_type" {
  default = "t2.micro"
}

## Subnets
variable "private_subnets" {
  description = "Private subnet IP CIDRs"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnet IP CIDRs"
  type        = list(string)
}