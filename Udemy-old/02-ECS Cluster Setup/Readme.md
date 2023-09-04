# ECS Cluster Setup & Architecture
- An Amazon ECS cluster is a **logical grouping** of `tasks` or `services`, which run on **infrastructure (EC2)** that is registered to a ECS cluster.
- The EC2 instances have to run an **`ECS agent`** (a docker container) to use the ECS service.
  - **`ECS agent`** once up **registers** the EC2 instance to the ECS cluster.
  - **`ECS AMI`**: special AMI that has `ECS agent` **pre-installed**.
   
    ![image](https://user-images.githubusercontent.com/36029504/148690576-f4b5f2b8-f715-4108-ac41-0f61838caa5d.png)

## ECS Cluster + IAM Setup
- EC2 instance with `ECS Agent`
- Attach an `EC2 Instance Profile`
  - This will **allow** *EC2 to register with ECS*, *Send logs to CloudWatch* and *get images from ECR service*.
- As `ECS Agent` is fully **functioning**, this will allow us
  - **Run tasks** on EC2 instance and will have **`ECS Task Roles`** to run their own API aginst AWS.
    - **e.g.** if we run a ECS service that has a task that runs against S3 buckets, we will load a specific IAM role to do just that.
     
    ![image](https://user-images.githubusercontent.com/36029504/148690931-1631fc48-5bcb-4ac9-a8f4-d40246466960.png)

### ECS Architecture
![image](https://user-images.githubusercontent.com/36029504/148691044-7f517d96-249f-4a5c-b614-e60e94ab3297.png)

## ECS IAM ROLES
- **`EC2Role`**: Allows `ECS agent` on the EC2 hosts to **communicate** with **ECS** &  **ECR**. 
- **`ECSRole`**: **authorizes ECS to create & manage AWS resource on your behalf**.
- **`ECSTaskExecutionRole`**: **role attached to ECS Tasks**. **Allows ECS Tasks** to **call AWS Services on your behalf**.
- **`AutoScalingRole`**: used to allow **AWS Autoscaling to inspect stats** and **adjust scaleable targets**.
 
  ![image](https://user-images.githubusercontent.com/36029504/148792490-64051b93-8b7d-43f8-9fc4-606067f36569.png)
 
- **`EC2Role`** & **`AutoScalingRole`** are **ONLY** equired for EC2 based clusters.

  ![image](https://user-images.githubusercontent.com/36029504/148792424-ba911285-b3f8-4fee-9032-5f25fef2a248.png)


## Reference
- [IAM for Amazon Elastic Container Service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/security-iam.html)