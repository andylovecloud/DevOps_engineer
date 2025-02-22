# Modify resource from Lab-EC2-demo to use variables for region, ami, and instance_type
# If the variable is not set, the default value will be used as defined in variable.tf
# The variable.tf file in the same directory as the main.tf file is used to define the variables

provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = var.image_id # Ubuntu AMI ID for eu-north-1 region
  instance_type = var.instance_type

  tags = {
    Name = "example-EC2-instance"
  }
}
resource "aws_security_group" "example" {
    name        = "example-security-group"
    description = "Allow inbound traffic on ports 443, 80, 22, and 3306"
    vpc_id      = "vpc-12345678" # Replace with your VPC ID

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

