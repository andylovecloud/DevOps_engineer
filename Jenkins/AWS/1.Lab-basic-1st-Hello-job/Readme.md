# Introduction
*Jenkins* is an open source tool used to deploy and automate software development. It provides a continuous integration (CI) environment for building, testing, and deploying applications. 

Jenkins allows you to create jobs to perform tasks such as *building source, running automation tests, deploying applications*, and reporting results. By integrating with other tools and using available plugins, Jenkins can be customized and extended to suit your software development needs.

## Why is Jenkins so popular?

- *Ease of use*: Jenkins has a friendly and easy-to-use user interface. Users can create and manage jobs easily through a web interface.

- *Cross-platform*: Jenkins supports many different platforms and programming languages, allowing application development on many environments and operating systems (Windows, Linux, Mac, Docker).

- *Extensibility and flexibility*: Jenkins has a rich extensibility ecosystem with thousands of plugins available. This allows extending Jenkins's functionality and customizing the CI/CD process to the specific needs of the project.

- *Community support*: Jenkins has a large and active community, with many resources, tutorials, and forums to help users solve problems and share experiences.

## Instructions for installing Jenkins on EC2 (Ubuntu)
• Create an EC2 instance with Ubuntu AMI.
• Log in to the EC2 instance. (security group allow port 8080)
• Install Jenkins according to the following guide:
https://www.jenkins.io/doc/book/installing/linux/#debianubuntu
• Log in to Jenkins with the admin password,
• Install the plugins as recommended.
• Change the admin password.