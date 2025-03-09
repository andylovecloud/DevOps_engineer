By following the instruction from my online teacher https://github.com/hoanglinhdigital/devops-for-beginner, I'm exploring my Kubernetes's knowledge with hand-on labs.

## What is Container Orchestration?
Container Orchestration is the process of automating the deployment, management, scaling, migration, and monitoring of containers. Technologies such as Kubernetes, Docker Swarm, and Mesos are designed to help with container management.

Specific tasks that container orchestration can perform include:
- Managing the lifecycle of containers
- Providing automatic scaling.
- Providing recovery.
- Load balancing across containers
- Providing communication channels between containers (Networking).
- Providing security mechanisms for containers (Security).
- Managing resource allocation for containers.

There are many Container Orchestration technologies and Kubernetes is one of them.

<img width="577" alt="Screenshot 2025-03-09 at 19 27 58" src="https://github.com/user-attachments/assets/266d3973-8b72-4fec-b88c-2556d791949f" />


## Kubernetes:
|  |  |
|---|--- |  
|It's a Container Orchestration developed by Google. Kubernetes helps manage and automate the deployment of containers, while providing scalability and flexibility for your applications. It is an important tool in building efficient, distributed systems.|  <img width="251" alt="Screenshot 2025-03-09 at 19 33 44" src="https://github.com/user-attachments/assets/c2bd8806-247c-462b-9bd9-178b77857a51" />|

![what-is-K8S-37-1024x998](https://github.com/user-attachments/assets/e9ac9c02-ec5c-4174-abe1-b1977f69bcec)


### Why is Kubernetes used?

1. Automation: Kubernetes helps automate the deployment, scaling, and management of containerized applications. You can define rules & policies to automate Kubernetes's implementation of changes.

2. Scalability: Kubernetes allows you to scale your application easily by scaling out new containers without disrupting the service.

3. Isolation and reliability: Containers in Kubernetes are isolated from each other, ensuring that one container does not affect another. If a container fails, Kubernetes can automatically restart it.

4. Distributed and efficient: Kubernetes helps you deploy applications across multiple servers, making the most of resources.

5. Strong community support: Kubernetes is an open source project, has a large community, and a lot of documentation. Easily find solutions and support from the community.

![Diagramas-part-Kubernetes-Use-Cases-35-1024x747](https://github.com/user-attachments/assets/9a727538-76f3-462e-ad00-efc2e09deca8)


Kubernetes-Architecture:
![Kubernetes-Architecture-33-1024x991](https://github.com/user-attachments/assets/a9ef276a-d42b-4ed5-ae63-ef93da16de3a)


## Basic components of a Kubernetes cluster

<img width="1235" alt="Screenshot 2025-03-09 at 20 43 36" src="https://github.com/user-attachments/assets/3642703b-8264-4fcd-829e-3e316e1eff5e" />


A simple model of a K8s cluster consisting of Master nodes (Control Plane) and Worker nodes.

<img width="542" alt="Screenshot 2025-03-09 at 20 46 38" src="https://github.com/user-attachments/assets/d10e71d9-bd62-4be1-a588-ea1174f8e42f" />

### Control Plan (Master node)

|  |  |
|---|--- | 
| <img width="821" alt="Screenshot 2025-03-09 at 20 50 46" src="https://github.com/user-attachments/assets/0ed12645-db30-4653-9ba5-8d4b0da4b467" /> | <img width="321" alt="Screenshot 2025-03-09 at 20 50 52" src="https://github.com/user-attachments/assets/f58f4cef-2cde-4ec6-acd5-cf7c8386bbc9" /> |

_Source: https://kubernetes.io/docs/concepts/overview/components/_

### Work node

<img width="1369" alt="Screenshot 2025-03-09 at 21 01 05" src="https://github.com/user-attachments/assets/4cdb1eb7-bec7-4c0f-9142-a5835f94499c" />

- **kubelet**: agent running on Worker node that communicates with Master
- **k-proxy**: responsible for managing network communication
- **runtime**: helps run containers on worker nodes
- **kubectl**: command line tool for interacting with Kubernetes clusters

´´´
kubectl run my-hello-kube
kubectl get services
kubectl describe nodes my-node
kubectl apply –f myconfig.yaml
´´´

## Kubernetes concepts need to pay attention: 

<img width="1049" alt="Screenshot 2025-03-09 at 21 11 21" src="https://github.com/user-attachments/assets/7de49732-ce63-4c61-9fe9-6dcbcf0680b4" />





