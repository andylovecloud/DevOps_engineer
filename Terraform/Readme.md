# Introduction
- **Provider**: [HashiCorp](https://developer.hashicorp.com/terraform)
- **Language**: HashiCorp Configuration Language (HCL).
- **Support** cloud provider: [AWS](https://developer.hashicorp.com/terraform/tutorials/aws-get-started), GCP, Azure,...

## Mechanism of operation

<img width="852" alt="Terraform" src="https://github.com/user-attachments/assets/96aca952-091a-4971-99c3-89af48951352" />

## Components of Terraform
- **Template files (.tf)**: write under HCL to describe the expectation for infrastructure.
- **Providers**: plugins for Terraform to interact with APIs from cloud providers or applications.
- **Resources**: basic items for infrastructure such as: virtual machines, network, services,...
- **Terraform CLI**: commands to manage and control action of Terraform, including create /init, apply and destroy.
- **State Files**: store infrastructure status which created and managed.
- **Variables and Outputs**: Variables is used to customize the configuration, and the outputs are used to get the value from the created infrastructure.

## Steps to implement Terraform
1. **Initiate (terraform init)**: Prepare the working environment by initializing Terraform.
2. **Plan (terraform plan)**: Identify & plan what will happen to be created, changed or deleted.
3. **Apply (terraform apply)**: Apply changes to create or modify Infrastructure. Depending on the changes to the template, resources can be **added**, **modified**, or **deleted**.
4. **Destroy (terraform destroy)**: Destroy and delete Infrastructure. Delete all resources, _**only use when nescessary**_! (lab/dev/test)

<img width="414" alt="Terraform-implementation" src="https://github.com/user-attachments/assets/04a3a12d-b7a9-43b1-aa98-b8b4ff274ce1" />

**[Link to Terraform templates reference AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template)**