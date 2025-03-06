region             = "ap-southeast-1"
availability_zones = ["ap-southeast-1a", "ap-southeast-1b"]
workstation_ip = "123.20.239.118/32"
cidr_block = "10.10.0.0/16"
bastion_instance_type = "t3.micro"
bastion_ami = "ami-0fa377108253bf620"  #Ubuntu 22.04
app_instance_type     = "t3.micro"
app_ami = "ami-0fea1654c99ae8095" #Ubuntu 20.04
db_instance_type      = "t3.micro"
db_ami = "ami-0fa377108253bf620" #Ubuntu 22.04
keypair_path = "../keypair/udemy-key.pub"