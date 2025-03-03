This is the place where I document my understanding about VM, container and Docker knowledge. 

# What is situation / problems when using Virtual Machine now?

Suppose one fine day your boss assigned you the task of installing a new software on the company's production server, you carefully researched the necessary libraries and runtimes of this software and downloaded them all.

On the day of implementation, the first thing you will do is backup the server (of course 😎 ). You install a library Jxxx version 20, but during the installation process Jxxx says that two parallel versions cannot exist on the same machine and you must remove the older version first. You remove the old version Jxxx 19 from the machine and install Jxxx 20 (newer is of course better).

After completing the software installation, you inform your boss that the job is done.

30 minutes later, the customer calls and claims that some software that has been working normally until now cannot be started today and gives an error of missing a library. 

And then.... T.T 😭

## Problems when using Virtual Machine (VM)
- Version conflicts between Library, Binary, Runtime installed on the same VM.
- Inability to be environment independent between applications.
- Time consuming in deployment (preparing OS, installing necessary libraries, setting up environment, etc.).
- Difficult to ensure consistency of deployed applications (application works OK on one environment but not sure if it will run normally on another environment).

<img width="483" alt="Virtual-Machine-architect" src="https://github.com/user-attachments/assets/1f1f0894-138c-40e8-b386-781583e1438d" />

## What is a Container? Why do we need a Container?
**Containers** were created to solve these problems, by:
- Packaging the application along with everything needed to run the application into an image that can be run anywhere that supports containers.
- Providing the environment & resource allocation mechanism so that the image can be run.
- Providing the mechanism & tools that allow developers to package, store, distribute and deploy applications conveniently.

<img width="452" alt="Container-architect" src="https://github.com/user-attachments/assets/125cb141-3d28-4d4d-8b3e-8ddc09422e68" />

## Benefits of Using Containers
1. Environment Independence: Containers provide a way to package an application and all its dependencies, including OS, libraries, tools. It allows the application to run independently and consistently on any environment.

2. Simplify the deployment process: Consistency, speed, convenience are what Containerlize brings when compared to the traditional model.

3. Efficient resource management: deploying an application using Containers allows you to share and use system resources efficiently. By running multiple containers on the same physical server or virtual machine, you can make the most of the system's computing power and resources.

4. Flexibility and scalability: Containers allow you to easily scale your application as needed. By scaling horizontally, the application can scale to meet the workload. Additionally, it is easy to deploy multiple versions of an application at the same time.

|                    | 
|---------------     |
|![docker-2](https://github.com/user-attachments/assets/012ac008-224e-4ed8-b60f-cac57a60c4de)|
|_VMs and Containers illustrated (zonov.me)_|


# What is Docker?
|                    |               |
|---------------     |-------------- |
|Docker is a software platform that allows you to build, test, and deploy applications quickly. Docker packages software into standardized units called containers that contain everything the software needs to run, including libraries, system tools, code, and runtime. Using Docker, you can quickly deploy and scale applications into any environment and know that your code will run (build one – run anywhere). | <img width="292" alt="Docker-logo" src="https://github.com/user-attachments/assets/64d6ffa4-f829-4d09-a9f9-e843fed82f21" />|


## Basic components of Docker

<img width="953" alt="Basic-component-of-Docker" src="https://github.com/user-attachments/assets/e1d39a74-f4f2-4677-b337-298ec08d0769" />



