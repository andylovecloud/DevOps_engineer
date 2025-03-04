# Lab 2: Build & Run a simple container using Dockerfile.

## Requirements:
- Design a Dockerfile using httpd image, use COPY directive to copy html code from workspace into container, start server and expose to port 80.
- Build image, run container from image, map with 8080 of host.
- Test access via browser.
- Stop container, delete created container.
- Delete created image.

---------
Code

#Prepare Dockerfile as sample.
#Run below command to build image.
docker build -t my-http-image .
#check image
docker images
#Run below command to run container.
docker run -d -p 8080:80 --name my-httpd-container my-http-image
#Go to browser and check 
http://localhost:8080/index.html