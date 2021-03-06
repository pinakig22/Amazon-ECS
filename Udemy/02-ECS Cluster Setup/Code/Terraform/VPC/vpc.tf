module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    name = var.vpc_name
    azs = var.az
    cidr = var.vpc_cidr
    private_subnets = var.private_subnet
    public_subnets = var.public_subnet

    tags = {
        Terraform = "true"
        Environment = "ecs-training"
        #Name = var.vpc_name
        #vpc_tags = var.vpc_name
    }
    
}
  
