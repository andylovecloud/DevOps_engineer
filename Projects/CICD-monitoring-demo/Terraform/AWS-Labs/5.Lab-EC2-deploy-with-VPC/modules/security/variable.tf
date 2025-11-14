variable "region" {
  type        = string
  default     = "eu-north-1"
}
variable "vpc_id" {
  type = string
  description = "The VPC ID"
  nullable = false
  
}