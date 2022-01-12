# Task Networking
- The following are the available **network modes**. Amazon ECS recommends using the `awsvpc` network mode unless you have a specific need to use a different network mode.

  ![image](https://user-images.githubusercontent.com/36029504/149079637-adb447a9-168b-42f9-81eb-613fc74de64c.png)  

  - **`awsvpc`** — The task is allocated its own elastic network interface (ENI) and a primary private IPv4 address. This gives the task the same networking properties as Amazon EC2 instances. 

  - **`bridge`** — The task utilizes Docker's **built-in virtual network** which runs inside each EC2 instance hosting the task.
    - With the `bridge` network mode, you use `static` or `dynamic` **port mappings** to map ports in the container with ports on the Amazon EC2 host. 
    - You **can't run** *more than a ***single*** instantiation of a task on each host* when using `static` mapping. This is because a `static` port mapping **only allows a single container to be mapped** to port. 
    - The `bridge` network mode with a dynamic port mapping solves the problem with `static` mapping. By **not specifying a host port** in the port mapping, you can have Docker choose a **random, unused** port from the **`ephemeral` port range** and **assign it** as the `public host port` for the container.  
     
      **`STATIC`**  
      ![image](https://user-images.githubusercontent.com/36029504/149081955-feea0a8d-d24a-4c9e-8226-39880050a0b6.png)

  
      **`DYNAMIC`**
      ![image](https://user-images.githubusercontent.com/36029504/149082039-28e5bad3-3e0c-40f3-9713-ea20a91dc4b9.png)
     
  - **`host`** — The task **bypasses** Docker's built-in virtual network and **maps container ports directly to the ENI of the Amazon EC2 instance** hosting the task. As a result, you **can't run** *multiple instantiations of the same task* on a **single** EC2 instance when port mappings are used.
    - It's **not supported** when using Amazon ECS on **Fargate**.
  
  - **`none`** — The task has no external network connectivity.
