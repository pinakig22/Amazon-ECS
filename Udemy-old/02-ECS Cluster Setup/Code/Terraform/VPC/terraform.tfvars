# Environmet Name
# env = <put_name>
env = "ecs-training"

# VPC Name
# vpc_name=<put_name>
vpc_name = "ecsStudy"

# Region
# region=<put_region>
region = "ap-south-1"

# Availability Zones
# Put AZs in a region
az = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

# VPC CIDR Block
# Define VPC network
vpc_cidr = "172.16.0.0/16"

# Subnets
# Define public and private subnets CIDRs
private_subnet = ["172.16.0.0/24"] #["172.16.1.0/24","172.16.2.0/24"]
public_subnet = ["172.16.3.0/24"]  #["",""]