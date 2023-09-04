# Task Networking
- The networking **behavior** of Amazon ECS tasks hosted on Amazon EC2 instances is **dependent on** the `network mode` defined in the `task definition`. 
- The following are the available **network modes**. Amazon ECS recommends using the `awsvpc` network mode unless you have a specific need to use a different network mode.

  ![image](https://user-images.githubusercontent.com/36029504/149079637-adb447a9-168b-42f9-81eb-613fc74de64c.png)  

## `awsvpc`
- The task is allocated its own elastic network interface (ENI) and a primary private IPv4 address. This gives the task the same networking properties as Amazon EC2 instances. 
- **Highest network performance** out of 3 as each **task gets their own** *Network Interface* and *IP*.

  ![image](https://user-images.githubusercontent.com/36029504/149613431-9f237590-a9e5-4ab4-858e-c7468d94a956.png)
- The `awsvpc` network mode is **compatible** with VPCs that are configured for **IPv6 dual stack mode**. A VPC using dual stack mode **can communicate** over **IPv4, IPv6,** or **both**. Each subnet in the VPC can have both an IPv4 CIDR range and an IPv6 CIDR range. 
- **Limitation**:
  - If you're using an **EC2** in `awsvpc` mode, then you are **limited by maximum number of network interfaces that can be attached to the EC2 instance.**
    This limits **how many tasks you can place** on each instance. Amazon ECS provides the **ENI trunking** feature which increases the number of available ENIs to achieve more task density.  
    ![image](https://user-images.githubusercontent.com/36029504/149613455-0f1ef68b-18a3-4e50-9a62-67b5323a9437.png)

  - By assigning a separate IP address to each task, you can simplify your overall infrastructure and maintain security groups that provide a great level of security. However, this configuration can lead to **IP exhaustion**.

## `bridge`
- The task utilizes Docker's **built-in virtual network** which **runs inside** each EC2 instance **hosting** the `task`.
  ![image](https://user-images.githubusercontent.com/36029504/149613308-ce468243-9aaf-4700-9a69-4c17e40f291f.png)
  
- With the `bridge` network mode, you use **`static`** or **`dynamic`** port mappings to map ports in the container with ports on the Amazon EC2 host. 
  - You **can't run** *more than a ***single*** instantiation of a task on each host* when using **`static`** mapping. This is because a **`static`** port mapping **only allows a single container to be mapped** to port. 
  - The **`bridge`** network mode with a **dynamic** port mapping solves the problem with **`static`** mapping. By **not specifying a host port** in the port mapping, you can have Docker choose a **random, unused** port from the **`ephemeral` port range** and **assign it** as the `public host port` for the container.
  - Specifying **`0`** as **host port** in _`container defintion`_ means assigning **`dynamic`** port on the host.
    ![image](https://user-images.githubusercontent.com/36029504/149605410-8aa8d3f1-1449-4130-88bf-abcb1bc18249.png)
     
      ### `STATIC` 
      ![image](https://user-images.githubusercontent.com/36029504/149081955-feea0a8d-d24a-4c9e-8226-39880050a0b6.png)  

      ### `DYNAMIC` 
      
      ![image](https://user-images.githubusercontent.com/36029504/149082039-28e5bad3-3e0c-40f3-9713-ea20a91dc4b9.png)
 
 ## `host`
- The task **bypasses** Docker's built-in virtual network and **maps container ports directly to the ENI of the Amazon EC2 instance** hosting the task. 
  ![image](https://user-images.githubusercontent.com/36029504/149613551-930c57b0-672c-4646-bd02-290c5cbfda5f.png)

- As a result, you **can't run** *multiple instantiations of the same task* on a **single** EC2 instance when port mappings are used.
- It's **not supported** when using Amazon ECS on **Fargate**.

- **Maximum network performance**.

  ![image](https://user-images.githubusercontent.com/36029504/149082492-01b3f314-9682-4d55-bc7c-b9fc8276abc3.png)
 
 ## `none`
 - The task has no external network connectivity.

## Reference
- [Choosing a network mode](https://docs.aws.amazon.com/AmazonECS/latest/bestpracticesguide/networking-networkmode.html)
