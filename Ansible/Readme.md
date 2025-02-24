# Introduction
- Ansible is a suite of software tools that enables infrastructure as code. Originally written by Michael DeHaan and acquired by Red Hat in 2015
- It is an open source project… For now…
- Ansible is a configuration management tool that can be used to manage the configuration of servers and other devices in an infrastructure.
- It can also be used to deploy applications and services to those servers. 
- Ansible can also be used to manage network devices. Also some cloud providers like AWS, Azure and Google Cloud Platform can be managed with Ansible.

<img width="385" alt="Ansible-logo" src="https://github.com/user-attachments/assets/1f9c7031-44d4-4642-a99d-4ae02df23a10" />


**Homepage**: https://docs.ansible.com/

## Ansible and GUI

- Ansible Tower (GUI) part of an annual RedHat Ansible Automation Platform subscription
- Ansible Tower is based on https://github.com/ansible/awx and that version is Free and open source
- There is alternative GUI to Ansible like https://github.com/ansiblesemaphore/semaphore.

<img width="590" alt="Ansible-GUI" src="https://github.com/user-attachments/assets/17bf56f7-faea-4cf6-b839-da7cc6743637" />


## Ansible concept
### Basic idea:
| Definition         | Example       |
|--------------- |----------------   |
| We have a control Node with a SSH login information and Ansible software |<img width="506" alt="Ansible-basic-idea" src="https://github.com/user-attachments/assets/87f60426-8bd6-4681-b935-5aa76ac9b34a" />|
|Control node will connect to other nodes (computers etc) and send needed configurations |**[Getting started with Ansible](https://docs.ansible.com/ansible/latest/getting_started/index.html#getting-started-with-ansible)** |
  



### Main structure:
- Ansible main structure can be divided to 4 different structures:
**1. Inventory**
**2. Playbooks
3. Roles
4. Modules / Plugins
**
- We will also need credentials to log in to servers

<img width="535" alt="Ansible-structure" src="https://github.com/user-attachments/assets/0b81a345-f854-483e-85c6-ccde4c36d2a6" />

### Ansible Inventory:
- Ansible Inventory is saving the connection information to nodes (servers) that are managed by Ansible.
- The inventory can be defined in a static file (JSON or Init) and it can be generated dynamically in various structures
- Ansible can get inventory information from other software like Terraform

<img width="420" alt="Ansible-inventory" src="https://github.com/user-attachments/assets/fddb3c22-2dc3-45f3-8f09-d0ed241655f8" />



### Ansible Playbooks
- Playbooks are automation blueprints, in YAML format, that Ansible uses to deploy and configure nodes in an inventory.

<img width="457" alt="Ansible-Playbook" src="https://github.com/user-attachments/assets/af92f519-0dbd-4546-b832-e3279978a666" />


### Ansible Modules:
- Ansible ships with a number of modules (called the ‘module library’) that can be executed directly on remote hosts or through Playbooks.
- Users can also write their own modules. These modules can control system resources, like services, packages, or files (anything really), or handle executing system commands. https://docs.ansible.com/ansible/2.9/modules/list_of_all_modules.html

### Ansible role:
- An Ansible role is a reusable and self-contained "unit" of automation in Ansible. Roles are designed to simplify and encapsulating specific functionality and configuration into modular components. Roles can be thought of as building blocks that can be stacked together to build complex automation workflows.
- Roles are also a way of organizing your playbooks. Roles are defined using YAML files with a predefined directory structure. Roles can be downloaded from Ansible Galaxy or created by yourself.
- Jeff Geerling is really active of making roles : https://ansible.jeffgeerling.com/

<img width="483" alt="Ansible-roles" src="https://github.com/user-attachments/assets/5971880a-4baf-4d7a-860d-b647b742aa0f" />

