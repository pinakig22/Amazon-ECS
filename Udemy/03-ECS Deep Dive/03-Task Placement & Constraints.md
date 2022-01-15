# ECS Task Placement
- When a `task` that uses the **EC2 launch type** is launched, Amazon ECS must **determine** where to place the task **based on the requirements** specified in the `task definition`, such as *CPU* and *memory*. 
  - Similarly, when you **scale down** the task count, Amazon ECS must determine **which tasks to terminate**. 
- You can apply **task placement strategies** and **constraints** to customize how Amazon ECS **places** and **terminates** tasks.
- **Task placement strategies** and **constraints** **aren't supported** for tasks using the **Fargate launch type**. 
  - By **default**, Fargate tasks are **spread across** *Availability Zones*. 
- With all other tasks, **default** task **placement strategies** **depend on** whether you're **running tasks** `manually` or `within a service`.