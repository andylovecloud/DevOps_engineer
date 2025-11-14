variable "region" {
  type        = string
  description = "The AWS region to launch the instance."
  default = "eu-north-1"
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

variable "ami_map" {
  type = map(any)
  default = {
    eu-north-1 = "ami-016038ae9cc8d9f51"
    eu-central-1 = "ami-06ee6255945a96aba"
  }
}

variable "ec2_security_group_ids" {
  description = "List of security group IDs to associate with"
  type        = list(string)
}
variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}
