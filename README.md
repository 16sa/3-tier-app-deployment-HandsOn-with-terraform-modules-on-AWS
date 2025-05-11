HandsOn Demo
1) Clone the github repo https://github.com/16sa/3-tier-app-deployment-HandsOn-with-terraform-modules-on-AWS.git
2) Create the AWS account - https://aws.amazon.com/console/
3) Install Docker and terraform on windows
https://docs.docker.com/desktop/install/windows-install/
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
For Docker Desktop, make sure to install WSL 2 Linux subsystem on your machine and Enable Hyper-V and Containers in Windows Features before installation 
Make sure to start Docker Desktop before proceeding with next steps
4) Install AWS CLI on you Machine
5) Create an IAM user from AWS console and add access key ID to that use, Make sure to save the Access key ID and Access secret somewhere.
6) From powershell or cmd tape "aws configure" Command with the following input:
AWS Access Key ID [None]: USER_ACCESS_KEY_ID
AWS Secret Access Key [None]: USER_SECRET_ACCESS_KEY
Default region name [None]: YOUR_AWS_REGION
Default output format [None]: json
You can verify your AWS CLI configuration by running this command "aws sts get-caller-identity"
7) Install jq Executabled on you windows machine
8) Grant the IAM user the necessary ECR permissions: From AWS console management, Navigate to the IAM console Users 
and create an IAM Policy for your created user with the following content, Update the Region according to your Location
you can name the policy ECR-ha-app-Permissions-eu-west-3 for example
9) Execute the linux command to give permission
chmod +x setup-ecrs.sh
10) Run this on terminal to create the ECR repo and to create images in local
and send those to ECR; Make sure to update the AWS region on the script
./setup-ecrs.sh
In summary, this script automates the process of:
Logging into your AWS ECR registry.
Creating two ECR repositories (ha-app-application-tier and ha-app-presentation-tier) if they don't already exist.
Navigating to the application-tier directory.
Building a Docker image for the application tier.
Tagging the application tier image with the correct ECR repository URI.
Pushing the application tier image to ECR.
Navigating to the presentation-tier directory.
Building a Docker image for the presentation tier.
Tagging the presentation tier image with the correct ECR repository URI.
Pushing the presentation tier image to ECR.
11) Before proceding with terraform session you need to Create a TerraformRole from AWS console Management and Attach the necessary policies
12) Ensure the User Has sts:AssumeRole Permission: Attach this AWSSTSServiceRoleAssume policy to user
13) We need to set trust relationship for the TerraformRole: This policy defines which entities are allowed to assume the role.
14) From powershell terminal run this command: 
aws sts assume-role --role-arn "arn:aws:iam::USER_ACCOUNT_ID:role/TerraformRole"  --role-session-name "TerraformSession"
15) Once you have these temporary credentials, you need to set them as environment variables in your terminal session so that Terraform can use them
From Powershell terminal run this command:
Write-Host $env:AWS_ACCESS_KEY_ID      # Replace with your actual Access Key ID
Write-Host $env:AWS_SECRET_ACCESS_KEY  # Replace with your actual Secret Access Key
Write-Host $env:AWS_SESSION_TOKEN      # Replace with your actual Session Token 
16) Make sure to put the suitable AWS Region in your terraform.tfvars file before proceeding
17) Go to terraform folder -
terraform init
terraform plan
terraform apply
18) Hit the Front end load balancerfront-
end-lb-**********.AWS_REGION.elb.amazonaws.com/
19) Delete the Architecture
terraform delete
20) Run this on terminal to delete the ECR repo
chmod +x destroy-ecrs.sh
./destroy-ecrs.sh
