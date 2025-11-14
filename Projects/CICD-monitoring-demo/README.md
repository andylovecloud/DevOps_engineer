# Introduction about this repo
This is a starting point for my journey to become a DevOps Engineer. Where I learn how to implement a solution in DevOps, via hand-on labs which improve my skills for deploying, managing, and monitoring cloud applications in AWS, Azure, GPC or review CI/CD pipelines, deployment methodologies, observability, and more.

## Definition
- [DevOps](https://www.ibm.com/downloads/documents/us-en/10a99803c9afdb83) (ebook) is a method in software development and infrastructure managememnt with the collaboration between Development(Dev) and Opeation team (Ops). DevOps aims to improve the software development lifecycle  by enhance the quality of product, speedup the CI/CD process and reduce mistake while implementatin. Adapt with change requests from customer easily and quickly.
- Wrong understanding about DevOps:
  + DevOps is a technology.
  + DevOps is a set of tools.
  + DevOps is a name of job possition in company.
 
## CI/CD - Continuous Integration and Continuous Deployment
- This is the oprocess to optimize the developement, testing and implementation. CICD accounts for most of the content and work time of a Devops Engineer.

<img width="1263" alt="CI-CD" src="https://github.com/user-attachments/assets/5b5def47-8673-42a1-bfc6-187bae7c4b6c" />

- The good Devops Engineer is not necessarily a person who knows many tools 😎. **Never** _one solution for all problems_ , CI/CD for every project is different, it depends on the experience of engineer and requirement of the project.


## Infrastructure as Code (IaC)
Use script to manage automatically infrastructure and provide solutions for:
- Speed up CI/CD process
- Reduce human mistake
- Improve productivities for repeating tasks.

Steps to implement Infra as code: 

<img width="722" alt="IAC" src="https://github.com/user-attachments/assets/6bf6b2eb-69be-477c-9771-029a571c1fa8" />


### Common tools in IaC:

![Screenshot 2025-03-13 at 9 53 00](https://github.com/user-attachments/assets/8a0966ed-46ba-4140-af0a-e8d9c9198f7b)


- **CloudFormation**: Provider: Amazon Web Services (AWS). This service allow users to define, implement infrastructure and resources by template(Yaml or Json)
- **AWS Cloud Development Kit (CDK)**: Tool allows define cloud infrastructure by popular programming languages: TypeScript, JavaScript, Python, C# and Java. Provision resource automatically. Basically, behind CDK still available CloudFormation stack.
- [**Terraform**](https://github.com/andylovecloud/DevOps_engineer/tree/main/Terraform): Provider: HashiCorp. Open source tool allows user define infrastructure as code, flexibility and compatibility with many cloud providers (AWS, Azure, GCP). Terraform does not create CloudFormation stack during deployment.
- **Azure Resource Manager (ARM) Templates**: Provider: Microsoft. This allows user define cloud infrastructure by JSON templates.
- **Google Cloud Deployment Manager**: Provider: Google Cloud. This allows user define cloud infrastructure and automation tasks by YAML configuration files.
- [**Ansible**](https://github.com/andylovecloud/DevOps_engineer/tree/main/Ansible): agentless model, install only in host machine. Use SSH to connect and manage servers. Use YAML to write playbook and roles.
- **Puppet**: agent-master model, install in all host machines. Use SSL to connect and manage servers. Code in private DSL(Domain Specific Language) of Puppet and Ruby.
- **Chef**: client-server model, install client in all servers. Use SSL to connect and manage servers. Use Ruby DSL to write recipes and cookbooks.
- [**Jenkins**](https://github.com/andylovecloud/DevOps_engineer/tree/main/Jenkins) is an open source tool used to deploy and automate software development. It provides a continuous integration (CI) environment for building, testing, and deploying applications. Jenkins allows you to create jobs to perform tasks such as _building source, running automation tests, deploying applications, and reporting results_. By integrating with other tools and using available plugins, Jenkins can be customized and extended to suit your software development needs.

![CICD-concepts](https://github.com/user-attachments/assets/b2b91224-10ae-4c11-a01e-a4ea17285cc2)




