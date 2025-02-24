variable "region" {
  type        = string
  description = "The AWS region to launch the instance."
  default = "eu-north-1"
}

#parameters for networking module
variable "availability_zone_1" {
  type = string
  nullable = false
}
variable "availability_zone_2" {
  type = string
  nullable = false
}
variable "cidr_block" {
  type = string
  nullable = false
}
variable "public_subnet_ips" {
  type = list(string)
  nullable = false
  
}
variable "private_subnet_ips" {
  type = list(string)
  nullable = false
}

variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
}

variable "instance_type" {
  type        = string
  description = "The type of instance to start."
  default = "t3.micro"
}
variable "amis" {
  type = map(any)
  default = {
    eu-north-1 = "ami-016038ae9cc8d9f51"
    eu-central-1 = "ami-06ee6255945a96aba"
  }
}

variable "keypair_path" {
  type        = string
  default = "../keypair/udemy-key.pub"
}