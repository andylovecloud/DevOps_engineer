# 1. Create a new file named main.tf in the Terraform/AWS/4.Lab-EC2-Output-to-Sub-modules directory.
provider "aws" {
  region = var.region
}
resource "aws_key_pair" "udemy-keypair" {
  key_name   = "udemy-keypair"
  public_key = file(var.keypair_path)
  }

module "security" {
  source = "./module/security"
  region = var.region
}
module "compute" {
  source = "./modules/compute"
  region = var.region
  image_id = var.ami_map[var.region]  
  instance_type = var.instance_type
  key_name = aws_key_pair.udemy-keypair.key_name
  ec2_security_group_ids = [module.security.public_security_group_id]
}