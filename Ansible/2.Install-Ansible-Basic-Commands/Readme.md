## LAB: Install Ansible and Test Basic Ansible (Ad-Hoc) Commands

This scenario shows:
- how to install ansible
- how to use basic commands

### Prerequisite

- You should have a look following lab, nodes that are created in that LAB, are using in ansible commands
  - [LAB: Multipass-SSH Configuration (Create Ansible Test Environment)](https://github.com/andylovecloud/DevOps_engineer/tree/main/Ansible/1.Create-Ansible-Test-Environment-with-Multipass)

### Steps

- Install Ansible on all nodes

``` 
sudo apt install ansible
``` 

- Create directory and inventory file to put managed nodes' IPs

![image](https://user-images.githubusercontent.com/10358317/201087999-7bbb7f0b-acdf-475a-b8c8-cf0f689bc29b.png)

- Put the managed nodes' IPs into the inventory file

<img width="580" alt="Ansible-inventory" src="https://github.com/user-attachments/assets/8ae680fa-ded8-4611-b3d8-e1d8a1b90cde" />

- Ping all nodes with ansible

``` 
ansible all -i inventory -m ping
``` 

<img width="455" alt="Ansible-ControlNode-ping-all-nodes" src="https://github.com/user-attachments/assets/db446dea-09a9-4919-b75c-3b224cf551f3" />


**NOTE:** If you use secure private SSH keys on each nodes (copied these keys on each nodes), it should be used "ansible all --key-file ~/.ssh -i inventory -m ping" 

- Create config file (ansible.cfg)

``` 
touch ansible.cfg
# copy followings:
[defaults]
inventory = inventory
# private_key_file = ~/.ssh/ansible
``` 

![image](https://user-images.githubusercontent.com/10358317/201090216-084d1328-88fc-462f-b307-d95c8d8b752d.png)

![image](https://user-images.githubusercontent.com/10358317/201090391-67057ecd-68a9-4aa6-af33-af5fcd099840.png)

- Using config file (ansible.cfg), we can use short commands

<img width="454" alt="Ansible-ping-by-ansible-cfg-file" src="https://github.com/user-attachments/assets/0b6d5c6e-fa0d-4d75-82fa-52408a8b24a1" />


- List all hosts

```
ansible all --list-hosts
``` 

<img width="407" alt="Ansible-list-host" src="https://github.com/user-attachments/assets/9e6fcf0f-ac46-4ba1-889e-a0e733ec2ae3" />

- Gather all nodes' information (all resources' information: cpu, ip, ssd, etc.) from all hosts

```
# -m parameter means ansible module
ansible all -m gather_facts
``` 

<img width="683" alt="Ansible-gather-facts-node" src="https://github.com/user-attachments/assets/f131d010-f7d7-4fc5-a8e2-79eb81cf6d33" />


- Gather information from specific node 

```
ansible all -m gather_facts --limit 172.26.215.23
```

- Run "sudo apt update" for all nodes using ansible
- As it is seen in the printscreen, it does not work. 

```
ansible all -m apt -a update_cache=true
```

<img width="950" alt="Ansible-update-cache-failed" src="https://github.com/user-attachments/assets/10f9ff40-c12b-4c52-b1df-92e305182f98" />


- The reason why "sudo apt update" does not work is to enter "sudo" password for all nodes.
- For now, we are assigning same password for all nodes (node1, node2). Later, it will be shown for different passwords.

```
sudo passwd ubuntu
```

![image](https://user-images.githubusercontent.com/10358317/201094654-23381802-43a2-4261-892b-900244019bcc.png)
![image](https://user-images.githubusercontent.com/10358317/201094744-d8edfd82-9c5a-4bb8-9fc5-7e9f5f4567c1.png)
![image](https://user-images.githubusercontent.com/10358317/201094827-5ddd50dd-bd26-47b9-b266-5d997678774b.png)

- Run "sudo apt update" for all nodes using "BECOME PASS", enter the common password when it asks

```
ansible all -m apt -a update_cache=true --become --ask-become-pass
```

<img width="697" alt="Ansible-changed-same-password" src="https://github.com/user-attachments/assets/ef93ac0f-cba5-474e-9f43-ce4d70cc0e0c" />


- Install specific package "sudo apt get snapd"

```
ansible all -m apt -a name=snapd --become --ask-become-pass
# latest version
ansible all -m apt -a "name=snapd state=latest" --become --ask-become-pass
```

<img width="652" alt="Ansible-install-specific-package" src="https://github.com/user-attachments/assets/f19c9c7e-b4c9-4d77-84c1-68c8a2cd0e65" />

