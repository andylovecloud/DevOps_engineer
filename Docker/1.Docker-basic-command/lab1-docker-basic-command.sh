#Practice getting familiar with Docker through the following operations
#Pull an image from docker registry (Docker Hub)
docker pull <image>:<tag>
#List image
docker images
#List all containers
docker ps
#Run a container from image
docker run -d -p <host port>:<container port> <image>:<tag>
#Some examples:
docker run -d -p 8080:80 nginx:latest

#Run container and interact directly in Interactive mode
docker run -it ubuntu:latest

#Run container and detach from interactive mode but keep the container running in the background and not exiting.
docker run -dit ubuntu:latest

#List all containers - All status
docker ps -a
#Start/Stop/Restart a container
docker start <container id>
docker stop <container id>
docker restart <container id>

#Delete a container
docker rm <container id>
#Force delete a container (even if it is running. *Be careful when using this command)
docker rm <container id> -f
#Delete an image:
docker rmi <image>:<tag>
#Or:
docker rmi <image id>
#SSH login to a running container, e.g. a Container running Ubuntu.
docker exec -it <container id> /bin/bash