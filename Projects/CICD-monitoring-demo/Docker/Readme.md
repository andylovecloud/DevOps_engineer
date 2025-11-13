This is the place where I document my understanding about VM, container and Docker knowledge. By following the hand-on labs from my online teacher https://github.com/hoanglinhdigital/devops-for-beginner.

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
|_VMs and Containers illustrated (zonov.me)_</center>|


# What is Docker?
|                    |               |
|---------------     |-------------- |
|[Docker](https://aws.amazon.com/vi/containers/) is a software platform that allows you to build, test, and deploy applications quickly. Docker packages software into standardized units called [containers](https://aws.amazon.com/vi/containers/) that contain everything the software needs to run, including libraries, system tools, code, and runtime. Using Docker, you can quickly deploy and scale applications into any environment and know that your code will run (build one – run anywhere). | <img width="292" alt="Docker-logo" src="https://github.com/user-attachments/assets/64d6ffa4-f829-4d09-a9f9-e843fed82f21" />|


## Basic components of Docker

<img width="953" alt="Basic-component-of-Docker" src="https://github.com/user-attachments/assets/e1d39a74-f4f2-4677-b337-298ec08d0769" />

- **Docker daemon**: is the place to manage Docker components such as images, containers, volumes, networks. Docker daemon receives API from Client to execute tasks.
- **Docker Client**: Provides methods to interact with Docker daemon.
- **Docker registry**: where docker images are stored. By default, docker will connect to the docker registry which is Docker hub.
_When you install Docker Desktop, Daemon and Client will be on the same computer._

## Basic Steps to Build a Docker Application
1. **Prepare a Dockerfile**: A Dockerfile describes the steps required to create a container environment that will contain your application.
2. **Build Docker Image**: Use the docker build command to build a Docker Image from the Dockerfile.
3. **Test the Docker Image**: Use the docker images command to check the list of Docker images available on your computer. Make sure that your application's Docker Image has been successfully built and appears in the list.
4. **Run Docker Container**: Use the docker run command to run a container from the Docker Image.
5. **Test the application**: Access your application via the IP address or domain name along with the specified port.

## Dockerfile
- Dockerfile defines a directive to have Docker build a custom image, which content your own source code.
- Base image declaration: Dockerfiles usually start with a **FROM** directive to specify the base image that the new Docker image will be based on. For example: **FROM ubuntu:latest, FROM httpd etc.**
- Copy files and directories: Using the **COPY** or **ADD** directive, you can copy files and directories from the host where the Dockerfile is run into inside the Docker image. For example: **COPY app.py /app, COPY . /usr/local/apache2/htdocs/**
- **RUN** directive. You can execute commands inside the image build process for example to install software, update packages or perform other tasks. For example: **RUN apt-get update && apt-get install -y python.**
- Setting environment variables: Using the **ENV** directive, you can define environment variables for the Docker image. For example: **ENV LOGLEVEL=DEBUG.**
- Open ports: Using the **EXPOSE** directive, you can specify the ports that the application in the Docker image will listen on. For example: **EXPOSE 80**.
- Run the application: Using the **CMD** directive, you can specify the command that Docker will run when starting a container from the image. For example: **CMD ["python", "/app/app.py"]**

<img width="564" alt="Screenshot 2025-03-04 at 13 13 09" src="https://github.com/user-attachments/assets/e103d199-2867-4723-84b6-0993cc011b3d" />

### Distinguishing the COPY directive and the ADD directive
- COPY and ADD both support copying files/folders.
- ADD supports decompression during copying, copying from URLs on the Internet.
- COPY does not support decompression or support URLs on the Internet.

In addition to the CMD directive, there is another directive called ENTRYPOINT that is also used to define the command that will run when the Container starts, but there is a difference:
- ENTRYPOINT defines the process that will be executed inside the container
- CMD defines the default arguments provided to the entrypoint process.

Usually, ENTRYPOINT will define the path to the process that will be executed, CMD defines the param (if any).
By default, ENTRYPOINT is not defined, docker will understand the entry point as **/bin/sh -c**





