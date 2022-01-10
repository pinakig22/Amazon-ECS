module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    name = "my-ecs-vpc"
    azs = var.az
    cidr = var.vpc_cidr
    #private_subnets =
    public_subnets = var.public_subnet

    tags = {
        Terraform = "true"
        Environment = "ecs-training"
    }
    
}
  
