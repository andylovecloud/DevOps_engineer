# Lab 5 - Working with Docker in Jenkins.

Proceed to install Docker & Docker compose for Jenkins:

- https://docs.docker.com/engine/install/ubuntu/
- https://docs.docker.com/compose/install/linux/
- add step to add group of docker
>sudo usermod -a -G docker jenkins
>sudo systemctl restart jenkins

**Requirements**:
- Create an ECR repository. Grant ECR permissions to the Jenkins server.
- Create a build job that checkouts code from a Github repository.
- Build source code to create artifact.
- Use nginx image to build a custom image.
- Push the built image to ECR.
- Check the result after build.