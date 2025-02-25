## LAB: Multipass-SSH-Configuration (Create Ansible Test Environment)

This scenario shows:
- how to install multipass
- how to create control node, managed nodes
- how to configure ssh between control node and managed nodes



### Steps

- "Multipass is a mini-cloud on your workstation using native hypervisors of all the supported plaforms (Windows, macOS and Linux)"
- Fast to install and to use.
- **Link:** https://multipass.run/
- Install on Linux, Windows and MacOs: https://multipass.run/install
- After installing, we can create VMs on our local machine.

``` 
# creating controlnode, managed nodes (node1, node2, etc.)
# -c => cpu, -m => memory, -d => disk space
multipass launch --name controlnode -c 2 -m 2G -d 10G   
multipass launch --name node1 -c 2 -m 2G -d 10G
multipass launch --name node2 -c 2 -m 2G -d 10G
multipass list
``` 

<img width="991" alt="Multipass-install-node-controlnode" src="https://github.com/user-attachments/assets/9be923cf-d800-49f6-a83e-1536fe341b2b" />


- Connect VMs by opening shells

``` 
# get shell on controlnode
multipass shell controlnode
# get shell on node1, on different terminal
multipass shell node1
# get shell on node2, on different terminal
multipass shell node2
``` 

<img width="811" alt="Multipass-get-shell-controlnode" src="https://github.com/user-attachments/assets/50fb4348-e3cb-4c12-9423-3bf367c185a1" />


``` 
sudo apt update
sudo apt install net-tools
# to see IPs
ifconfig
``` 

- Create ssh public key on control plane
- Copy the public key from control plane

``` 
> on controlnode
ssh-keygen (no password, enter 3 times)
cat ~/.ssh/id_rsa.pub (copy the value)
``` 

<img width="840" alt="Multipass-generate-ssh-key" src="https://github.com/user-attachments/assets/3f67d6ac-b588-4948-9a8c-5562108efeb3" />


- Paste copied public key (control plane) into the authorized_keys in each managed nodes.

``` 
cd .ssh (on each workers)
nano authorized_keys 
> Paste keys from controlnode (hence managed nodes know the controlnode IP and public key, controlnode can connect it)
``` 

![image](https://user-images.githubusercontent.com/10358317/201083610-d4141690-d5d7-4f9c-90ba-dbfb6743b2d1.png)

- List all VMs to get IPs

```
multipass list
```

![image](https://user-images.githubusercontent.com/10358317/201084356-c34f3629-7e86-4e15-9cad-3361b5a49f34.png)

- SSH from controlplane to node1

```
ssh <IP>
or 
ssh <username>@<IP>
```

![image](https://user-images.githubusercontent.com/10358317/201084577-1028dc59-be04-4cb4-982b-f3dca1ea6251.png)

### References
- https://techsparx.com/linux/multipass/enable-ssh.html
