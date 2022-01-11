# Task Definitions, ECS Services & IAM Roles

# ECS Task Definitions
- To prepare your application to run on Amazon ECS, you **must create** a `task definition`. 
- The `task definition` is a **text** file (in **`JSON` format**) that describes (metadata) one or more containers (up to a **maximum of 10**) that form your application.
- It contains crucial information around:
  - **Image Name**.
  - **Port binding** for Container & Host
  - Amount of **CPU & Memory** required for the task.
  - **Environment Variables**
  - **Networking Modes** to use for the containers in your task.
  - The **IAM role** that your tasks should use.
  - Any **data volumes** that should be used with the containers in the task.
  - The **command** the container should **run** when it is started.
  - The **logging configuration** to use for your tasks

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
- 

## ECS Service