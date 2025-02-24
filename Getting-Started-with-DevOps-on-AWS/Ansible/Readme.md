# Introduction
- Ansible is a suite of software tools that enables infrastructure as code. Originally written by Michael DeHaan and acquired by Red Hat in 2015
- It is an open source project… For now…
- Ansible is a configuration management tool that can be used to manage the configuration of servers and other devices in an infrastructure.
- It can also be used to deploy applications and services to those servers. 
- Ansible can also be used to manage network devices. Also some cloud providers like AWS, Azure and Google Cloud Platform can be managed with Ansible.

**Homepage**: https://docs.ansible.com/

## Ansible and GUI

- Ansible Tower (GUI) part of an annual RedHat Ansible Automation Platform subscription
- Ansible Tower is based on https://github.com/ansible/awx and that version is Free and open source
- There is alternative GUI to Ansible like https://github.com/ansiblesemaphore/semaphore.


## Ansible concept
### Basic idea:
- We have a control Node with a SSH login information and Ansible software
- Control node will connect to other nodes (computers etc) and send needed configurations

### Main structure:
- Ansible main structure can be divided to 4 different structures:
1. Inventory
2. Playbooks
3. Roles
4. Modules / Plugins

- We will also need credentials to log in to servers
