
# Practice deploying a complete VPC + resources
1. Practice creating and deploying a complete VPC with the following components:
• 2 public subnets, 2 private subnets
• Public route table, Private route table
• 1 Internet Gateway, 1 NAT Gateway
• Check the created resources.
*Note* using the module to separate into a separate networking module
2. Deploy additional *security + compute* module after the *networking* module is successfully deployed.
• Security Group receives vpc id taken from the *networking* module output
• EC2 receives Security Group ID taken from the *security* module output



<img width="1209" alt=" Terraform-Output-to-Sub-modules-with-VPC" src="https://github.com/user-attachments/assets/ab714d60-08eb-47d1-9b0e-8d58760a8934" />
