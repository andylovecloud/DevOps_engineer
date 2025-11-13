## LAB: Implement First Playbook

This scenario shows:
- how to create ansible playbooks
- how to run "apt install" command in the playbook
- how to run "update" command in the playbook
- how to run "apt remove" command in the playbook
- how to run command according to distribution (when)

### Prerequisite

- You should have a look following lab, nodes that are created in that LAB, are using in ansible commands
  - [LAB: Multipass-SSH Configuration (Create Ansible Test Environment)](https://github.com/andylovecloud/DevOps_engineer/tree/main/Ansible/1.Create-Ansible-Test-Environment-with-Multipass)

### Steps

- Create playbook to install apache2 app on nodes

#### "Apt Install" command in the playbook

``` 
nano install_apache.yml
# copy followings:
---

- hosts: all
  become: true
  tasks:

  - name: install apache2 package
    apt:
      name: apache2
``` 

![image](https://user-images.githubusercontent.com/10358317/201101204-780321bf-57b7-450b-89e9-1c5d6deb5e39.png)

![image](https://user-images.githubusercontent.com/10358317/201100926-480de972-078e-4541-9f06-30b625c71585.png)

- Run playbook

``` 
ansible-playbook --ask-become-pass install_apache.yml
``` 

- Under Task "install apache2 package", status are changed, this means installing apache2 packet on the nodes successfully

<img width="937" alt="Ansible-install-apache-via-playbook" src="https://github.com/user-attachments/assets/28bb9e9d-7a60-4b5a-9837-346edd5d37e2" />

- If you run again that command, it is seen that "ok" under the Task "install apache2 package", it means that there is no change

<img width="827" alt="Ansible-install-apache-via-playbook-again-no-change" src="https://github.com/user-attachments/assets/87295d02-fce1-46ab-870a-89037231ec1d" />

- When you enter the one of the nodes' IP on the browser, you can see that the apache2 server is installed on it

![Screenshot 2025-02-25 at 15 05 55](https://github.com/user-attachments/assets/abcdeebf-5f85-4b63-92be-59724e4fbc12)


- If you enter "never-existed-tect-package" as apt name, you can see that it cannot install on the nodes, because it does not exist.

<img width="943" alt="Screenshot 2025-02-25 at 15 09 02" src="https://github.com/user-attachments/assets/b9e75a9b-fa9a-4e3f-b833-f8c5dce6428b" />


#### "Update" command in the playbook

- Add "apt update" and install other packages

``` 
---

- hosts: all
  become: true
  tasks:

  - name: update repository index
    apt:
      update_cache: yes

  - name: install apache2 package
    apt:
      name: apache2

  - name: add php support for apache
    apt:
      name: libapache2-mod-php
``` 
<img width="388" alt="Screenshot 2025-02-25 at 15 12 26" src="https://github.com/user-attachments/assets/241b51ec-0049-4dc8-8793-e3fc4dc9a8ee" />

``` 
ansible-playbook --ask-become-pass install_apache.yml
``` 

<img width="833" alt="Screenshot 2025-02-25 at 15 12 54" src="https://github.com/user-attachments/assets/173833f9-83ed-4a28-8005-8a11448a2631" />


- Add "state: latest" to install latest version of the app

``` 
---

- hosts: all
  become: true
  tasks:

  - name: update repository index
    apt:
      update_cache: yes

  - name: install apache2 package
    apt:
      name: apache2
      state: latest

  - name: add php support for apache
    apt:
      name: libapache2-mod-php
      state: latest
```

<img width="896" alt="Screenshot 2025-02-25 at 15 15 42" src="https://github.com/user-attachments/assets/c5b2fd96-dabe-48f7-8dbc-4724080339e6" />


#### "Apt remove" command in the playbook

- Create "remove_apache.yml" to uninstall apps.
- Use "state:absent" to uninstall.

``` 
---

- hosts: all
  become: true
  tasks:

  - name: remove apache2 package
    apt:
      name: apache2
      state: absent

  - name: add php support for apache
    apt:
      name: libapache2-mod-php
      state: absent
```

![image](https://user-images.githubusercontent.com/10358317/201107052-4e2c2d50-d7e7-44dd-8352-bd91f7e7be6b.png)

``` 
ansible-playbook --ask-become-pass remove_apache.yml
``` 

<img width="873" alt="Screenshot 2025-02-25 at 15 17 26" src="https://github.com/user-attachments/assets/0bfc4d81-3467-428b-bdce-39760953a328" />


- When browsing IP to see whether apache2 works or not, it is seen that apache2 server was uninstalled.

![Screenshot 2025-02-25 at 15 17 57](https://github.com/user-attachments/assets/9bb8f320-44b7-4882-b7ea-e30f027c42c0)


#### Command According to the Distribution ("when")

- Add 'when: ansible-distribution == "Ubuntu"' into the install_apache.yaml file
- With 'when', it is possible to install command on specific distro (e.g. Ubuntu, Centos)

``` 
---

- hosts: all
  become: true
  tasks:

  - name: update repository index
    apt:
      update_cache: yes
    when: ansible_distribution in ["Debian", "Ubuntu"]

  - name: install apache2 package
    apt:
      name: apache2
      state: latest
    when: ansible_distribution == "Ubuntu"

  - name: add php support for apache
    apt:
      name: libapache2-mod-php
      state: latest
    when: ansible_distribution == "Ubuntu"
```
- To get more information about the specific node. 

```
ansible all -m gather_facts --limit 192.168.64.6 | grep ansible_distribution
```

<img width="773" alt="Screenshot 2025-02-25 at 15 31 55" src="https://github.com/user-attachments/assets/7f929ca7-c2d6-488a-81ed-6c5dbb60adc1" />


- It is possible to use 'when' commands with other details (e.g. "ansible_distribution_version": "22.04")

- Adding new tasks for 'CentOS' distribution

```
---

- hosts: all
  become: true
  tasks:

  - name: update repository index
    apt:
      update_cache: yes
    when: ansible_distribution in ["Debian", "Ubuntu"]

  - name: install apache2 package
    apt:
      name: apache2
      state: latest
    when: ansible_distribution == "Ubuntu"

  - name: add php support for apache
    apt:
      name: libapache2-mod-php
      state: latest
    when: ansible_distribution == "Ubuntu"

  - name: update repository index
    dnf:
      update_cache: yes
    when: ansible_distribution == "CentOS"

  - name: install apache2 package
    dnf:
      name: httpd
      state: latest
    when: ansible_distribution == "CentOS"

  - name: add php support for apache
    dnf:
      name: php
      state: latest
    when: ansible_distribution == "CentOS"
```
Run: 
``` 
ansible-playbook --ask-become-pass install_apache.yml
``` 
- Tasks that are defined for 'CentOS' are skipped

<img width="881" alt="Screenshot 2025-02-25 at 15 34 06" src="https://github.com/user-attachments/assets/1610a283-05dd-4404-9345-02cbfe37285c" />


### Reference

- https://www.youtube.com/watch?v=VANub3AhZpI&list=PLT98CRl2KxKEUHie1m24-wkyHpEsa4Y70&index=6
