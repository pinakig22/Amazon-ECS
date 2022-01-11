# ECS Setup
## Core Infrastructure
- VPC
- Subnets
- IGW

  ![image](https://user-images.githubusercontent.com/36029504/148805590-35a839d9-32b4-41db-aab7-25736d403479.png)

### using CloudFormation yaml file
`aws cloudformation create-stack --capabilities CAPABILITY_IAM --stack-name ecs-core-infrastructure --template-body file://./core-infrastructure-setup.yml`

## EC2 Based Setup

![image](https://user-images.githubusercontent.com/36029504/148889969-ed6c33dd-ea2c-4f22-b9f4-7be454d88848.png)


## Fargate Setup
