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

  ```
  "placementStrategy": [
    {
        "type": "random"
    }
  ]
  ```
### `spread`

## References
- [ECS Task Placement](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement.html)
- [ECS Task Placement Strategies](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement-strategies.html)
