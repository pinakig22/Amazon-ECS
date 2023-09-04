# ECS Quickstart

## What is ECS
- **ECS** = Elastic Container Service
- Amazon ECS is a **fully managed container orchestration service** that makes it easy for you to **deploy, manage,** and **scale** containerized applications.
- **Launch Docker containers** on AWS
- **We** need to **provision & maintain** the infrastructure (the EC2 instances)
- **AWS takes care** of **starting/stopping** containers.
- **Integrates** with *Application Load Balancer*.

  ![image](https://user-images.githubusercontent.com/36029504/148515293-2f2a8063-8911-44e4-8387-f209fb64825a.png)


## What is Fargate
- AWS Fargate is a **serverless, pay-as-you-go compute engine** that lets you **focus** on building applications without managing servers. 
- AWS Fargate is **compatible with** both *Amazon Elastic Container Service (ECS)* and *Amazon Elastic Kubernetes Service (EKS)*.
- **Launch Docker containers** on AWS
- Fargate **removes the operational overhead** of *scaling, patching, securing,* and *managing* servers.
- **Only pay for what you use**. 
  - Fargate **scales** the compute to **closely match** your *specified resource requirements*. With Fargate, there is **no over-provisioning** and **paying** for **additional** servers.
   
  ![image](https://user-images.githubusercontent.com/36029504/148515260-afada574-62f6-41b5-8fa4-f0f531651514.png)

## ECS EC2 vs FARGATE
- To run containers, you have two options. You can use `ECS container instances`, or you can use `Fargate`. **Both options work** together with ECS. 
  The following figure demonstrates the difference.
  
  ![image](https://user-images.githubusercontent.com/36029504/148945565-2375e765-0f27-4df3-8ddf-fd6d7da47c2f.png)

## ECS Quick Start

### Diagram of ECS objects and how they relate

![image](https://user-images.githubusercontent.com/36029504/148687795-d930b725-5f97-45b2-89fc-80b882b422ba.png)

- **Container Definition**: **Choose an image** for your container or **define the container image to use**.
- **Task Definition**: A task definition is a **`blueprint` for your application**, and **describes one or more containers through `attributes`**. 
  - Some `attributes` are **configured at the task level** but the **majority of `attributes` are configured per container**.
    - **Task definition name**: specifies task definition name.
    - **Network Mode**: The **Docker networking mode** to use for the containers in the task. **Default**: `awsvpc`
    - **Task execution role**: The role that **authorizes Amazon ECS to pull private images and publish logs** for your task. This **takes the place of the EC2 Instance role when running tasks**.
    - **Compatibilities**: The **launch type** to use with your task.
  
    ![image](https://user-images.githubusercontent.com/36029504/148688582-1622031b-fb1d-49f5-a99a-1d41b26e083c.png)

- **Service**: A service **allows you to run and maintain a specified number** (the "`desired count`") **of simultaneous instances of a task definition** in an ECS cluster.
  - **Service name**
  - **Number of desired tasks**
  - **Security group**
    - If you **do not use** a **load balancer**, a security group is created to **allow all public traffic** to **your service ONLY on the container port specified**. 
    - If **you use an Application Load Balancer**, **two security groups are created** to secure your service: 
      - An **Application Load Balancer security group** that allows **all traffic on the Application Load Balancer port** and 
      - an **Amazon ECS security group** that **allows all traffic ONLY from the Application Load Balancer security group**. 
  - **Load balancer type** (optional): An **Elastic Load Balancing load balancer** distributes incoming traffic across the tasks running in your service.
  
  - ![image](https://user-images.githubusercontent.com/36029504/148688602-eb7b310e-8709-4204-961d-d4cbbfe0c9c0.png)

- **Cluster**: Configure your cluster.
  - **Cluster Name**: Cluster names are **unique per account per region**. Up to 255 letters (uppercase and lowercase), numbers, and hyphens are allowed.
  - **VPC ID**: The **ID of the VPC** to be used by the container.
  - **Subnets**: The **ID of the subnet** to be used by the container. A subnet is a range of IP addresses in a VPC.
   
    ![image](https://user-images.githubusercontent.com/36029504/148688557-5dbfa892-8a14-4129-8113-42b92683bea4.png)

## ECS Pricing
- Reference: [Fargate Pricing in Context](https://www.trek10.com/blog/fargate-pricing-vs-ec2)
 
  ![image](https://user-images.githubusercontent.com/36029504/148688909-bd98d324-22c1-42cf-a9d5-1c39d4111464.png)

## ECS vs EKS vs Beanstalk
|ECS|EKS|Beanstalk|
|---|---|---|
|Docker on AWS|Docker on AWS|**PaaS** (Platform as a service) on AWS|
|Proprietary from AWS|Leveraging **Kubernetes** on AWS|Used to run Java, Node.js, Python, C# applications|
|Good Integration with other AwS Services|Open Source Tooling|Has **special mode** to run Single or Multi Docker container|
|2 Launch Modes: **EC2** & **Fargate**|2 Launch Modes: **EC2** & **Fargate**|Can Leverage ECS service.</br> **Way Less Customization**</br> **Cannot go deep** into microservice architecture|

## Docker Primer
![image](https://user-images.githubusercontent.com/36029504/148689533-cf9719ca-3452-4fd2-958b-4d375b2fa301.png)


## References
- [What is Amazon ECS](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/Welcome.html)
