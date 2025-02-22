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
