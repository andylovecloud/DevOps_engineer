# Practice getting familiar with Docker through the following operations

## Check Docker version and Login into Docker hub from terminal (created account is required)

```
docker --version
docker login
```
 <img width="891" alt="Screenshot 2025-03-04 at 11 21 45" src="https://github.com/user-attachments/assets/9f07f004-c98f-43c9-88f6-16198c767839" />


## Pull an image from docker registry (Docker Hub)
```
docker pull <image>:<tag>
```
## List image
```
docker images
```
<img width="612" alt="Screenshot 2025-03-04 at 11 24 10" src="https://github.com/user-attachments/assets/a2415adf-a170-43e1-b7b5-9053b4dd0bfc" />


## List all containers
```
docker ps
```
 
<img width="622" alt="Screenshot 2025-03-04 at 11 25 20" src="https://github.com/user-attachments/assets/bb199013-185f-4d57-b42c-dd4cf4d9c2c3" />


## Run a container from image
```
docker run -d -p <host port>:<container port> <image>:<tag>
```

#Some examples:
```
docker run -d -p 8080:80 nginx:latest
```

<img width="1102" alt="Screenshot 2025-03-04 at 11 26 27" src="https://github.com/user-attachments/assets/2ae76371-8996-4ba8-a351-a829868bd52f" />

Load the URL: localhost:8080 in the browser to check the result:
![Screenshot 2025-03-04 at 11 27 03](https://github.com/user-attachments/assets/b62f5aea-7ad6-4cce-a1fd-b34ac77fa898)


## Run container and interact directly in Interactive mode (-it)
```
docker run -it ubuntu:latest
```
## Run container and detach from interactive mode but keep the container running in the background and not exiting. (-dit)
```
docker run -dit ubuntu:latest
```
<img width="1120" alt="Screenshot 2025-03-04 at 11 38 05" src="https://github.com/user-attachments/assets/f13bd16d-0d01-4ea8-a247-dab8fd62dc5c" />

## Start/Stop/Restart a container
```
docker start <container id>
docker stop <container id>
docker restart <container id>
```
<img width="749" alt="Screenshot 2025-03-04 at 11 31 40" src="https://github.com/user-attachments/assets/0be8b9e0-327f-4dfb-b1ad-aef16f9fa2af" />

If the container is running, you have to stop the container before remove it.

<img width="1116" alt="Screenshot 2025-03-04 at 11 30 28" src="https://github.com/user-attachments/assets/5375946e-1de2-49cb-af43-cbc17c81b43e" />


## Delete a container
```
docker rm <container id>
```
<img width="1097" alt="Screenshot 2025-03-04 at 11 38 05" src="https://github.com/user-attachments/assets/9941c771-a4b1-498e-8391-029a1f9b7f72" />


## Force delete a container (even if it is running. *Be careful when using this command)
```
docker rm <container id> -f
```
## Delete an image:
```
docker rmi <image>:<tag>
```
## Or:
```
docker rmi <image id>
```
## SSH login to a running container, e.g. a Container running Ubuntu.
```
docker exec -it <container id> /bin/bash
```
<img width="803" alt="Screenshot 2025-03-04 at 11 38 17" src="https://github.com/user-attachments/assets/32ec0202-4540-42a0-a3c6-11fa60bd1d34" />



