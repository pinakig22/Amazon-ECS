####################################
# Creates SG needed by ECS Cluster #
####################################
module "ecs-security-group" {
  source = "terraform-aws-modules/security-group/aws"
  description = "Security group for ECS Cluster"
  # name = "${var.env}-ecs-sg"
  name = "${var.env}-ecs-sg"
  vpc_id = module.vpc.vpc_id
  
  #ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Test Security Group for ESC Cluster"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  tags = {
   Name = "${var.vpc_name}-sg"
   Environment = "ecs-training"
  }

}