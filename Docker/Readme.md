This is the place where I document my understanding about VM, container and Docker knowledge. 

# What is situation / problems when using Virtual Machine now?

Suppose one fine day your boss assigned you the task of installing a new software on the company's production server, you carefully researched the necessary libraries and runtimes of this software and downloaded them all.

On the day of implementation, the first thing you will do is backup the server (of course ☺ ). You install a library Jxxx version 20, but during the installation process Jxxx says that two parallel versions cannot exist on the same machine and you must remove the older version first. You remove the old version Jxxx 19 from the machine and install Jxxx 20 (newer is of course better).

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
Containers were created to solve these problems, by:
- Packaging the application along with everything needed to run the application into an image that can be run anywhere that supports containers.
- Providing the environment & resource allocation mechanism so that the image can be run.
- Providing the mechanism & tools that allow developers to package, store, distribute and deploy applications conveniently.

