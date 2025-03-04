# Lab 2: Build & Run a simple container using Dockerfile.

## Requirements:
- Design a Dockerfile using httpd image, use COPY directive to copy html code from workspace into container, start server and expose to port 80.
- Build image, run container from image, map with 8080 of host.
- Test access via browser.
- Stop container, delete created container.
- Delete created image.

## Execution
### Prepare Dockerfile as sample.

```
FROM httpd

COPY ./web/index.html /usr/local/apache2/htdocs/

RUN chown www-data:www-data /usr/local/apache2/htdocs/index.html

ENV LOGFILE=/var/log/httpd/access.log

EXPOSE 80

CMD ["httpd-foreground"]
```

### Run below command to build image.
```
docker build -t my-http-image .
```
<img width="1128" alt="Screenshot 2025-03-04 at 13 25 51" src="https://github.com/user-attachments/assets/136b8aa9-dedc-412a-8e4e-5e96ba1c04af" />

<img width="1119" alt="Screenshot 2025-03-04 at 13 26 29" src="https://github.com/user-attachments/assets/fe6652ef-63b7-4f6e-8354-d8b4e7135dfb" />


#### check image
```
docker images
```
<img width="741" alt="Screenshot 2025-03-04 at 13 27 05" src="https://github.com/user-attachments/assets/beb64798-5629-4e5d-a11d-0c0860331454" />


<img width="741" alt="Screenshot 2025-03-04 at 13 27 05" src="https://github.com/user-attachments/assets/348bc456-43cd-4cc2-84e7-fea97f57e37f" />

### Run below command to run container.
```
docker run -d -p 8080:80 --name my-httpd-container my-http-image
```

<img width="1133" alt="Screenshot 2025-03-04 at 13 42 05" src="https://github.com/user-attachments/assets/4728cfc2-08e1-4910-961f-c63c91f2aa6f" />


### Go to browser and check 
```
http://localhost:8080/index.html
```

![Screenshot 2025-03-04 at 13 36 18](https://github.com/user-attachments/assets/c5594ee7-952a-4ff6-8abe-64892d903415)

