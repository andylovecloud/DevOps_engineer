
# Lab 7: Combination Services
1. Analyze & create a modular Terraform structure.
2. Practice implementing Terraform template according to available design.
3. Deploy a basic stack to AWS including
 - VPC, Subnet, Security Group.
 - EC2, Application Load Balancer, Target Group, Autoscaling Group.
 - MongoDB database.

## Objective:
Create an advanced AWS VPC to host a fully functioning cloud native application.

![Screenshot 2025-03-06 at 13 01 11](https://github.com/user-attachments/assets/469a27f8-86ff-47a3-9508-31fce1381789)


_Cloud Native Application_


The VPC will span 2 AZs, and have both public and private subnets. An internet gateway and NAT gateway will be deployed into it. Public and private route tables will be established. An application load balancer (ALB) will be installed which will load balance traffic across an auto scaling group (ASG) of Nginx web servers installed with the cloud native application frontend and API. A database instance running MongoDB will be installed in the private zone. Security groups will be created and deployed to secure all network traffic between the various components.

For demonstration purposes only - both the frontend and the API will be deployed to the same set of ASG instances - to reduce running costs.

https://github.com/cloudacademy/terraform-aws/tree/main/exercises/exercise4

<img width="723" alt="Screenshot 2025-03-06 at 10 23 18" src="https://github.com/user-attachments/assets/543a2f8b-fab9-4773-b7e6-ae9cb391f6ba"


The auto scaling web application layer bootstraps itself with both the Frontend and API components by pulling down their latest respective releases from the following repos:

- Frontend: https://github.com/cloudacademy/voteapp-frontend-react-2020/releases/latest
- API: https://github.com/cloudacademy/voteapp-api-go/releases/latest



The original template of this application was outdate, the below code was the one updated for the **_application module's main.tf_** file:

```
terraform {
  required_version = ">= 1.4.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}

#====================================

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  #userdata
  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    #! /bin/bash
    apt-get -y update
    apt-get -y install nginx
    apt-get -y install jq

    ALB_DNS=${aws_lb.alb1.dns_name}
    MONGODB_PRIVATEIP=${var.mongodb_ip}
    
    mkdir -p /tmp/cloudacademy-app
    cd /tmp/cloudacademy-app

    echo ===========================
    echo FRONTEND - download latest release and install...
    mkdir -p ./voteapp-frontend-react-2023
    pushd ./voteapp-frontend-react-2023
    curl -sL https://api.github.com/repos/cloudacademy/voteapp-frontend-react-2023/releases/latest | jq -r '.assets[0].browser_download_url' | xargs curl -OL
    INSTALL_FILENAME=$(curl -sL https://api.github.com/repos/cloudacademy/voteapp-frontend-react-2023/releases/latest | jq -r '.assets[0].name')
    tar -xvzf $INSTALL_FILENAME
    rm -rf /var/www/html
    cp -R build /var/www/html
    cat > /var/www/html/env-config.js << EOFF
    window._env_ = {REACT_APP_APIHOSTPORT: "$ALB_DNS"}
    EOFF
    popd

    echo ===========================
    echo API - download latest release, install, and start...
    mkdir -p ./voteapp-api-go
    pushd ./voteapp-api-go
    curl -sL https://api.github.com/repos/cloudacademy/voteapp-api-go/releases/latest | jq -r '.assets[] | select(.name | contains("linux-amd64")) | .browser_download_url' | xargs curl -OL
    INSTALL_FILENAME=$(curl -sL https://api.github.com/repos/cloudacademy/voteapp-api-go/releases/latest | jq -r '.assets[] | select(.name | contains("linux-amd64")) | .name')
    tar -xvzf $INSTALL_FILENAME
    #start the API up...
    MONGO_CONN_STR=mongodb://$MONGODB_PRIVATEIP:27017/langdb ./api &
    popd

    systemctl restart nginx
    systemctl status nginx
    echo fin v1.00!

    EOF    
  }
}


#====================================

#tfsec:ignore:aws-ec2-enforce-launch-config-http-token-imds
resource "aws_launch_template" "apptemplate" {
  name = "application"

  image_id               = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.webserver_sg_id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name  = "FrontendApp"
      Owner = "Udemy"
    }
  }

  user_data = base64encode(data.template_cloudinit_config.config.rendered)
}

#====================================

#tfsec:ignore:aws-elb-alb-not-public
resource "aws_lb" "alb1" {
  name                       = "alb1"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb_sg_id]
  subnets                    = var.public_subnets
  drop_invalid_header_fields = true
  enable_deletion_protection = false

  /*
  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  }
  */

  tags = {
    Environment = "Prod"
  }
}

resource "aws_alb_target_group" "webserver" {
  vpc_id   = var.vpc_id
  port     = 80
  protocol = "HTTP"

  health_check {
    path                = "/"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 6
    timeout             = 5
  }
}

resource "aws_alb_target_group" "api" {
  vpc_id   = var.vpc_id
  port     = 8080
  protocol = "HTTP"

  health_check {
    path                = "/ok"
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 6
    timeout             = 5
  }
}

#tfsec:ignore:aws-elb-http-not-used
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb1.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.webserver.arn
  }
}

resource "aws_alb_listener_rule" "frontend_rule1" {
  listener_arn = aws_alb_listener.front_end.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["/"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.webserver.arn
  }
}

resource "aws_alb_listener_rule" "api_rule1" {
  listener_arn = aws_alb_listener.front_end.arn
  priority     = 10

  condition {
    path_pattern {
      values = [
        "/languages",
        "/languages/*",
        "/languages/*/*",
        "/ok"
      ]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.api.arn
  }
}

#====================================

resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = var.private_subnets

  desired_capacity = var.asg_desired
  max_size         = var.asg_max_size
  min_size         = var.asg_min_size

  target_group_arns = [aws_alb_target_group.webserver.arn, aws_alb_target_group.api.arn]

  launch_template {
    id      = aws_launch_template.apptemplate.id
    version = "$Latest"
  }
}

data "aws_instances" "application" {
  instance_tags = {
    Name  = "FrontendApp"
    Owner = "Udemy"
  }

  instance_state_names = ["pending", "running"]

  depends_on = [
    aws_autoscaling_group.asg
  ]
}
```

## ALB Target Group Configuration

The ALB will configured with a single listener (port 80). 2 target groups will be established. The frontend target group points to the Nginx web server (port 80). The API target group points to the custom API service (port 8080).

![AWS-VPC-FullApp-TargetGrps](https://github.com/user-attachments/assets/9e2c6fde-6b24-40ef-8aa8-e0f31035101d)

_AWS Architecture_

**Project Structure**
```
├── main.tf
├── modules
│   ├── application
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── vars.tf
│   ├── bastion
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── vars.tf
│   ├── network
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── vars.tf
│   ├── security
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── vars.tf
│   └── storage
│       ├── install.sh
│       ├── main.tf
│       ├── outputs.tf
│       └── vars.tf
├── outputs.tf
├── terraform.tfvars
└── variables.tf

```

### TF Variable Notes

- <mark>workstation_ip </mark>: The Terraform variable workstation_ip represents your workstation's external perimeter public IP address, and needs to be represented using CIDR notation. This IP address is used later on within the Terraform infrastructure provisioning process to lock down SSH access on the instance(s) (provisioned by Terraform) - this is a security safety measure to prevent anyone else from attempting SSH access. The public IP address will be different and unique for each user - the easiest way to get this address is to type "what is my ip address" in a google search. As an example response, lets say Google responded with 202.10.23.16 - then the value assigned to the Terraform workstation_ip variable would be 202.10.23.16/32 (note the /32 is this case indicates that it is a single IP address).

- <mark>key_name</mark>: The Terraform variable key_name represents the AWS SSH Keypair name that will be used to allow SSH access to the Bastion Host that gets created at provisioning time. If you intend to use the Bastion Host - then you will need to create your own SSH Keypair (typically done within the AWS EC2 console) ahead of time.
   - The required Terraform workstation_ip and key_name variables can be established multiple ways, one of which is to prefix the variable name with TF_VAR_ and have it then set as an environment variable within your shell, something like:
   - Linux: <mark>export TF_VAR_workstation_ip=202.10.23.16/32</mark> and <mark>export TF_VAR_key_name=your_ssh_key_name</mark>
   - Windows: <mark>set TF_VAR_workstation_ip=202.10.23.16/32</mark> and <mark>set TF_VAR_key_name=your_ssh_key_name</mark>

- Terraform environment variables are documented here: https://www.terraform.io/cli/config/environment-variables
















## Troubleshoot
If you are using MacOS, especialy from chip **Apple M1** to latest version. You might meet below error while run "**terraform init**":

```
Error: Incompatible provider version
│ 
│ Provider registry.terraform.io/hashicorp/template v2.2.0 does not have a package available for your current platform, darwin_arm64.
│ 
│ Provider releases are separate from Terraform CLI releases, so not all providers are available for all platforms. Other versions of this provider may have
│ different platforms supported.
```


![Screenshot 2025-03-06 at 12 17 24](https://github.com/user-attachments/assets/da6bdb55-7b32-43c7-adf9-098113bb3ae1)

Then you might run the following steps below to solved the problem:

```
brew install kreuzwerker/taps/m1-terraform-provider-helper
m1-terraform-provider-helper activate
m1-terraform-provider-helper install hashicorp/template -v v2.2.0
```

![Screenshot 2025-03-06 at 12 31 29](https://github.com/user-attachments/assets/f5d483cf-4cd1-4211-833e-b0294df1bc61)


Then run again  "**terraform init**" to check the result.



