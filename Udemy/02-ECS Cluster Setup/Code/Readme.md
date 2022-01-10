# ECS Setup
## Core Infrastructure
- VPC
- Subnets
- IGW

  ![image](https://user-images.githubusercontent.com/36029504/148805590-35a839d9-32b4-41db-aab7-25736d403479.png)

### using CloudFormation yaml file
`aws cloudformation create-stack --capabilities CAPABILITY_IAM --stack-name ecs-core-infrastructure --template-body file://./core-infrastructure-setup.yml`

## EC2 Based Setup

## Fargate Setup
