# AWS ECS cluster created using Terraform
This is a Terraform project that creates resources in AWS for EC2 instance, VPC, Load Balancer, Autoscaling and an ECS cluster with capacity provider, task definition and service.

1. Inside vpc.tf there are resources needed to create a private network in cloud
2. Inside ec2.tf there are resources needed to create an EC2 instance
3. Inside main.tf there are resources needed to create an ECS cluster

Instructions for initiating Terraform:
1. Make sure the CLI is configured for your AWS account with the required credentials with the command:
   - aws configure
2. Initialize the Terraform:
   - terraform init
3. Check the added resources:
   - terraform plan
4. Apply the added resources
   - terraform apply
5. If there is need for destroy:
   - terraform destroy 
   
