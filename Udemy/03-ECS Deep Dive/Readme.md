# Task Definitions, ECS Services & IAM Roles

## ECS Task Definitions
- To prepare your application to run on Amazon ECS, you **must create** a `task definition`. 
- The `task definition` is a **text** file (in **`JSON` format**) that describes (metadata) one or more containers (up to a **maximum of 10**) that form your application.
- It contains crucial information around:
  - **Image Name**
    - Defined within `Container Definition` while setting up Task.
      - **`Essential`**: If the `essential` parameter of a container is marked as **`true`**, the **failure of that container will stop the task**.
  - **Task Size**
    - specify the **total** `cpu` and **`memory`** used for the task.
    - Task size is **required** for tasks using the **Fargate** launch type and is **optional** for the **EC2**.
    - Task size is **not supported** for **Windows** containers.
  - **Port binding** for Container & Host
  - Amount of **CPU & Memory** required for the task.
  - **Environment Variables**
  - **Networking Modes** to use for the containers in your task.
    - **Fargate** `task definitions` require that the **network mode** is set to `awsvpc`. 
    - The `awsvpc` network mode provides **each task with its own elastic network interface**. 
    - **EC2** `task definitions` provies the following **Network mode**. If we choose **`default`**, ECS will start your container using Docker's default networking mode, which is **`Bridge` on Linux** and **`NAT` on Windows**.
      
  - The **IAM role** that your `tasks` should use.
    - In **EC2** mode, this is **optional**, and it will use the IAM Role that is attached to EC2 instance.
    
      ![image](https://user-images.githubusercontent.com/36029504/149079677-a4934cce-9f99-41d6-a0d3-6010994c1440.png)

  - Any **data volumes** that should be used with the containers in the task.
  - The **command** the container should **run** when it is started.
  - The **logging configuration** to use for your tasks
    
 ### Fargate
  ![image](https://user-images.githubusercontent.com/36029504/149049193-4ff64045-1cad-4eb5-ad5e-b2a99c824f08.png)

### EC2
 
- The **entire application stack** **DOES NOT need** to be on a **single** `task definition`, and in most cases it should not.
  - The application **can span** *multiple* `task definitions`. You can do this by **combining related containers** into their own `task definitions`, each representing a single component.

  ![image](https://user-images.githubusercontent.com/36029504/148964586-8b6cb73a-6165-425f-8792-00a2f306b649.png)

  
## ECS IAM Roles
### `EC2 Instance Profile`
- Used by **`ECS Agent`**.
- This will **allow** *EC2 to register with ECS*, *Send logs to CloudWatch*, *Make API Calls to ECS Service* and *get images from ECR service*

### `ECS Task Role`
- **Allows each tasks** to have a **specific** role, and they will be allowing your **tasks to perform specific actions** on other services such as Amazon S3 bucket.
- Can use **different `Task roles` for different `ESC Services`**.
- `Task Role` is **defined** in **`task definition`**.

  ![image](https://user-images.githubusercontent.com/36029504/148966068-2477a3b4-e4ec-4a34-abf9-1fa3e0564b8d.png)

## ECS Service
- An `ECS Service` **allows you to run and maintain** a specified **number of instances of a task definition** simultaneously in an `ECS cluster`. 
- So they **help define** ***how many tasks should be run at any point of time*** and ***how they should be run***.
- If any of your `tasks` should **fail or stop** for any reason, the `ECS service scheduler` **launches another instance** of your` task definition` **to replace** it in order to **maintain the desired number of `tasks`** in the `service`.
- You can **run** your `service` *behind* a **load balancer**. 
  - The load balancer **distributes traffic** across the `tasks` that are associated with the `service`.
  - Application Load Balancers offer several features that make them attractive for use with Amazon ECS services:
    - Application Load Balancer, allow containers to use `dynamic host port mapping`, so that **multiple tasks from the same service** are *allowed per container instance*.
    - They are supported by `tasks` **hosted on** both **Fargate** and **EC2** instances.
    - Each `service` can **serve traffic from multiple load balancers** and **expose** multiple **load balanced ports by specifying multiple target groups**. (`Dynamic port forwarding`)
    - Application Load Balancers support **path-based routing** and **priority rules** (so that ***multiple** `services` can use the **same** `listener port` on a **single** Application Load Balancer*).
  
    ![image](https://user-images.githubusercontent.com/36029504/148967698-65d65c57-66c1-439d-897a-cb0bf9aae99e.png)

- **Service Type**: There are 2 types of **service type**
  - **`Replica`**: Replica services **place and maintain a desired number of tasks across the cluster**.
  - **`Daemon`**: Daemon service **place and maintain one copy of task on each container instance**.
    - If a **capacity provider** is used, Daemon service type is **not supported**.
- **Deployments**: defines the deployment type within a Service. Two types of Deployments:
  - **Rolling Updates**: 
    - replaces the current version of the task in the service a new version.
    - Set `minimum healthy percentage` and `maximum healthy percentage` to control the number of service's tasks in the **RUNNING** state during deployment.
  - **Blue/Green Deployment**
    - Allows to **verify** the new version **before** routing production traffic to it.



## References
- [ECS Task Definition](https://docs.aws.amazon.com/AmazonECS/latest/userguide/task_definitions.html)
- [Task definition parameters](https://docs.aws.amazon.com/AmazonECS/latest/userguide/task_definition_parameters.html)
- [ECS Services](https://docs.aws.amazon.com/AmazonECS/latest/userguide/ecs_services.html)
- [ECS Deployment types](https://docs.aws.amazon.com/AmazonECS/latest/userguide/deployment-types.html)
- [Choosing Network Mode](https://docs.aws.amazon.com/AmazonECS/latest/bestpracticesguide/networking-networkmode.html)
