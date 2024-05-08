# AWS ECS cluster created using Terraform
This is a Terraform project that creates resources in AWS for EC2 instance, VPC, Load Balancer, Autoscaling and an ECS cluster with capacity provider, task definition and service.

1. Inside [`vpc.tf`](https://github.com/Sebastianutcn/aws-ecs-cluster-terraform/blob/main/vpc.tf) there are resources needed to create a private network in cloud
2. Inside [`ec2.tf`](https://github.com/Sebastianutcn/aws-ecs-cluster-terraform/blob/main/ec2.tf) there are resources needed to create an EC2 instance
3. Inside [`main.tf`](https://github.com/Sebastianutcn/aws-ecs-cluster-terraform/blob/main/main.tf) there are resources needed to create an ECS cluster

## Installation
- Terraform command to initialize the project
```
terraform init
```
* Terraform command to plan the changes and to check again the resources that were added, changed or deleted
```
terraform plan -out plan.out
```
- Terraform command to apply the changes
```
terraform apply plan.out --auto-approve
```
