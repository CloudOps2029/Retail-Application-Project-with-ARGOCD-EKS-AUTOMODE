# EKS-Retail-Application-Project-with-ARGOCD-GitOps
Retail Store Sample App - GitOps with Amazon EKS Auto Mode
This is a sample application designed to illustrate various concepts related to containers on AWS. It presents a sample retail store application including a product catalog, shopping cart and checkout, deployed using modern DevOps practices including GitOps and Infrastructure as Code.

Quick Installation Scripts
🔧 One-Click Installation
Follow these steps to deploy the application:

Step 1. Configure AWS with Root User Credentials:
Ensure your AWS CLI is configured with the Root user credentials:

aws configure
Step 2. Clone the Repository:
git clone https://github.com/CloudOps2029/Retail-Application-Project-with-ARGOCD-EKS-AUTOMODE


Phase 1 of Terraform: Create EKS Cluster
In Phase 1: Terraform Initialises and creates resources within the retail_app_eks module.

cd retail-store-sample-app/terraform/
terraform init
terraform apply -target=module.retail_app_eks -target=module.vpc --auto-approve
image
This creates the core infrastructure, including:

VPC with public and private subnets
Amazon EKS cluster with Auto Mode enabled
Security groups and IAM roles
Step 6: Update kubeconfig to Access the Amazon EKS Cluster:
aws eks update-kubeconfig --name retail-store --region <region>

Phase 2 of Terraform: Once you update kubeconfig, apply the Remaining Configuration:
terraform apply --auto-approve
This deploys:

ArgoCD for Setup GitOps
NGINX Ingress Controller
Cert Manager for SSL certificates
Application is live with Public image:

Get your ingress EXTERNAL-IP and paste it in the browser to access retail-store application.
kubectl get svc -n ingress-nginx






