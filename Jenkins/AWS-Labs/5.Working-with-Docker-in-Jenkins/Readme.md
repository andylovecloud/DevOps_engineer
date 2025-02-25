# Lab 5 - Working with Docker in Jenkins.

Proceed to install Docker & Docker compose for Jenkins:

- https://docs.docker.com/engine/install/ubuntu/
- https://docs.docker.com/compose/install/linux/
- add step to add group of docker

### Trouble shoot error Permission denied, run the following commands in remote server
sudo usermod -a -G docker jenkins
sudo systemctl restart jenkins

**Requirements**:
- Create an ECR repository. Grant ECR permissions to the Jenkins server.
- Create a build job that checkouts code from a Github repository.
- Build source code to create artifact.
- Use nginx image to build a custom image.
- Push the built image to ECR.
- Check the result after build.

### Troubleshoot while "Build Now" in Jenkins
You might find this error while run "Build Now" after input the Ruby script (which will send data to AWS)

![Lab5 10-Error-While-Build-Code-in-Jenkins](https://github.com/user-attachments/assets/0d29ce22-1c30-4a83-9b65-ec923ff9d14a)

That mean your AWSCLi does not exist / install. then you can do the following:
1. Update package lists:

´´´
sudo apt update
´´´

2. Install required dependencies:
´´´
sudo apt install unzip curl -y

´´´

3. Download AWS CLI installer:

´´´
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
´´´

4. Unzip the downloaded file:
´´´
unzip awscliv2.zip
´´´

5. Run the installer:

´´´
sudo ./aws/install
´´´

6. Verify the installation:
´´´
aws --version
´´´

7. If installed correctly, you should see an output like:
´´´
aws-cli/2.x.x Python/x.x.x Linux/x86_64
´´´

