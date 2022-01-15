# ECS Task Placement
- When a `task` that uses the **EC2 launch type** is launched, Amazon ECS must **determine** where to place the task **based on the requirements** specified in the `task definition`, such as *CPU* and *memory*. 
  - Similarly, when you **scale down** the task count, Amazon ECS must determine **which tasks to terminate**. 
- You can apply **task placement strategies** and **constraints** to customize how Amazon ECS **places** and **terminates** tasks.
- **Task placement strategies** and **constraints** **aren't supported** for tasks using the **Fargate launch type**. 
  - By **default**, Fargate tasks are **spread across** *Availability Zones*. 
- With all other tasks, **default** task **placement strategies** **depend on** whether you're **running tasks** `manually` or `within a service`.
- **Task Placement Strategy**: is an **algorithm for selecting instances** for `task placement` or `tasks for termination`.
  - For example, Amazon ECS can select instances at **random**, or it can select instances such that tasks are **distributed evenly** across a group of instances.
- **Task Placement Constraint**: is a **rule that's considered during task `placement`**.
  - For example, you can use *constraints to ***place tasks based on*** Availability Zone or instance type*. 
  - You can also **associate attributes**, which are `name/value` pairs, with your container instances and then use a constraint to **place** tasks **based on attribute**.
- You can use **task placement** `strategies` and `constraints` **together**.
  - For example, you can use a task placement `strategy` and a task placement `constraint` to *distribute tasks across Availability Zones* and *`bin pack` tasks based on memory* within each Availability Zone, but **only** for G2 instances.
- When Amazon ECS **places tasks**, it uses the **following process** to select container instances:
  - Identify the instances that **satisfy** the *CPU, memory, and port requirements* in the task definition.
  - Identify the instances that **satisfy** the *task placement `constraints`*.
  - Identify the instances that **satisfy** the *task placement `strategies`*.
  - **Select the instances** for task placement.

  ![image](https://user-images.githubusercontent.com/36029504/149605888-936a3908-57d0-41d9-b713-bda3b428d7b3.png)

- You can specify task placement strategies with the following actions: 
  - **`CreateService`**
  - **`UpdateService`**
  - **`RunTask`**


## Task Placement Strategies

- Amazon ECS supports the following task placement strategies:

### `binpack`
- Tasks are **placed** on container instances so as to **leave the least amount** of **`unused` CPU or memory**. 
- This strategy **minimizes** the *number of container instances in use*.
- When this strategy is used and a `scale-in` action is taken, Amazon ECS **terminates** tasks.
  -  It does this based on the *amount of resources* that are **left** on the container instance **after** the task is terminated. 
  -  The container instance that has the **most available resources** left after task termination **has that task terminated**.

  ```json
  "placementStrategy": [
    {
        "field": "memory",
        "type": "binpack"
    }
  ]
  ```
  So we can see here, if we had two EC2 instances or a cluster `binpack`, we'll try to **cram** all the task on the one instance before going on to the other.
  
  ![image](https://user-images.githubusercontent.com/36029504/149606906-97483f36-044b-4e87-a901-9dce2a38ce3b.png)

### `random`
- Tasks are placed **randomly**.

  ```json
  "placementStrategy": [
    {
        "type": "random"
    }
  ]
  ```
### `spread`
- Tasks are placed **evenly** based on the **specified value**.
- Accepted values are `instanceId` (or `host`, which has the same effect), or any **platform or custom attribute** that's applied to a container instance, such as `attribute:ecs.availability-zone`.
- **Service tasks** are spread **based on the tasks from that service**. 
  - **Standalone tasks** are spread **based on the tasks from the same task group**.
- When the `spread` strategy is used and a **scale-in** action is taken, ECS selects tasks to **terminate** that **maintain a balance across** Availability Zones. 
  - **Within** an Availability Zone, **tasks are selected at random**.
- Good choise when we want to have **High Availability**
  
  **The following strategy distributes tasks evenly across Availability Zones.**

  ```json
  "placementStrategy": [
    {
        "field": "attribute:ecs.availability-zone",
        "type": "spread"
    }
  ]
  ```

  **The following strategy distributes tasks evenly across Availability Zones and then distributes tasks evenly across the instances within each Availability Zone.**

  ```
  "placementStrategy": [
    {
        "field": "attribute:ecs.availability-zone",
        "type": "spread"
    },
    {
        "field": "instanceId",
        "type": "spread"
    }
  ]
  ```

  **The following strategy distributes tasks evenly across Availability Zones and then bin packs tasks based on memory within each Availability Zone.**
  ```
  "placementStrategy": [
    {
        "field": "attribute:ecs.availability-zone",
        "type": "spread"
    },
    {
        "field": "memory",
        "type": "binpack"
    }
  ]
  ```


## Task Placement Constraints
- A task placement **`constraint`** is a **rule that's considered during task placement**. 
- Task placement constraints can be specified when **either running a task** or **creating a new service**. 
  - The task placement constraints can be **updated for existing services as well**.
- **Examples**
  - **Constraint types**: following types of task placement constraints:
    - `distinctInstance`: Place each task on a **different** container instance.

      ```json
      "placementConstraints": [
          {
              "type": "distinctInstance"
          }
      ]
      ```
    - `memberOf`: Place tasks on container instances that **satisfy an expression** defined by *Cluster Query Language*. The `memberOf` task placement constraint can be specified with the following **actions**:
      - Running a task
      - Creating a new task
      - Creating a new task defintion
      - Creating a revision of an existing task defintion.
  
      
      ```json
      "placementConstraints": [
          {
              "expression": "attribute:ecs.instance-type =~ t2.*",
              "type": "memberOf"
          }
      ]      
      ```

## References
- [ECS Task Placement](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement.html)
- [ECS Task Placement Strategies](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement-strategies.html)
- [ECS task placement constraints](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement-constraints.html)
