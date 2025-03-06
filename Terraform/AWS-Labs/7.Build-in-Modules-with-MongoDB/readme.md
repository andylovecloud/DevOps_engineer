
# Lab 7: Combination Services
1. Analyze & create a modular Terraform structure.
2. Practice implementing Terraform template according to available design.
3. Deploy a basic stack to AWS including
 - VPC, Subnet, Security Group.
 - EC2, Application Load Balancer, Target Group, Autoscaling Group.
 - MongoDB database.

**System diagram of the requirement**

<img width="723" alt="Screenshot 2025-03-06 at 10 23 18" src="https://github.com/user-attachments/assets/543a2f8b-fab9-4773-b7e6-ae9cb391f6ba" />

## Troubleshoot
If you are using MacOS, especialy from chip **Apple M1** to latest version. You might meet below error while run "**terraform init**":
´´´
**Error: Incompatible provider version**
│ 
│ Provider registry.terraform.io/hashicorp/template v2.2.0 does not have a package available for your current platform, darwin_arm64.
│ 
│ Provider releases are separate from Terraform CLI releases, so not all providers are available for all platforms. Other versions of this provider may have
│ different platforms supported.
´´´

![Screenshot 2025-03-06 at 12 17 24](https://github.com/user-attachments/assets/da6bdb55-7b32-43c7-adf9-098113bb3ae1)

Then you might run the following steps below to solved the problem:
´´´
brew install kreuzwerker/taps/m1-terraform-provider-helper
m1-terraform-provider-helper activate
m1-terraform-provider-helper install hashicorp/template -v v2.2.0
´´´
![Screenshot 2025-03-06 at 12 31 29](https://github.com/user-attachments/assets/f5d483cf-4cd1-4211-833e-b0294df1bc61)

Then run again  "**terraform init**" to check the result.



