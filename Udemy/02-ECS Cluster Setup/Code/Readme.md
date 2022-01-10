# ECS Setup
## Core Infrastructure
- VPC
- Subnets
- IGW

### using CloudFormation yaml file
`aws cloudformation create-stack --capabilities CAPABILITY_IAM --stack-name ecs-core-infrastructure --template-body file://./core-infrastructure-setup.yml`