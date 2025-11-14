#Use the following repository:
https://github.com/andylovecloud/nodejs-random-color
#You can use it directly or fork it to your github

#1. Create a pipeline job in Jenkins
#2. In the pipeline job, use Jenkinsfile to perform the following steps:
#- Checkout the source code from the repository on Git.
#- Use Dockerfile to build the image
#- Push the image to AWS ECR
# View the lab5.groovy file

#Trouble shoot error Permission denied, run the following commands in remote server
sudo usermod -a -G docker jenkins
sudo systemctl restart jenkins