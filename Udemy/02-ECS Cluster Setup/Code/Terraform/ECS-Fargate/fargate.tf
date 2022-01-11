################################
# Creating AWS Fargate Cluster #                   
################################
data "aws_vpc" "not-default" {
  default = false
} 


# ECS Cluster
resource "aws_ecs_cluster" "ecsfargateCluster" {
  name = "${var.vpc_name}-fargate"

  tags = {
    name  = "${var.env}-ecs-fargate-cluster"
    value = "enabled"
    Environment = var.env
  }
}

# ECS Tasks (task definition)

# ECS Service
resource "aws_ecs_service" "ecsCluster-service" {
  name = "ecsfargate-service"
  cluster = aws_ecs_cluster.ecsfargateCluster.id
  # task_definition = 
  desired_count = 1
  iam_role = "arn:aws:iam::855309002875:instance-profile/ecsInstanceRole"
  depends_on = [aws_ecs_service.ecsCluster-service.iam_role]

  network_configuration {
    subnets = ["${var.env}-private*"]
    security_groups = ["${var.vpc_name}-sg"]
  }

}

