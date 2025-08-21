
## Introduction
In today’s cloud-native world, applications aren’t just monoliths anymore. They’re **collections of microservices**, each running independently, scaling on demand, and deployed with speed.  

To demonstrate these concepts, I built the **Retail Store Sample App** — a fully cloud-native application deployed on **Amazon EKS**, following **GitOps** principles and cloud best practices.  

This article will walk you through the **architecture, deployment process, and lessons learned** from building this project.  

---

## Why This Project?
The goal wasn’t just to build a “retail store.” Instead, it was to **over-engineer an application** so it can be a learning ground for:

- **Microservices development** across different languages (Java, Go, Node.js).  
- **Container orchestration** with Kubernetes on AWS.  
- **GitOps automation** with ArgoCD and GitHub Actions.  
- **Infrastructure as Code** with Terraform.  
- **Dual-branch deployment strategies** for *demos vs production*.  

---

## Architecture Overview
The Retail Store is made up of **five core microservices**:

- **UI (Java)** → the frontend store interface  
- **Catalog (Go)** → product catalog API  
- **Cart (Java)** → shopping cart API with support for MongoDB/DynamoDB  
- **Orders (Java)** → order management API  
- **Checkout (Node.js)** → orchestrates the checkout process  

All of these services run on **EKS** and are managed with GitOps via **ArgoCD**.  

On the infrastructure side, **Terraform** provisions:  
- A secure **VPC**  
- An **EKS cluster** (with Auto Mode enabled)  
- **Ingress controllers, SSL certificates, and monitoring**  

---

## Deployment Strategy
This project follows a **dual-branch GitOps model**:

- **🌐 Main Branch (Public Deployment)**  
   Great for **quick demos and learning**. Uses stable public images (v1.2.2) with manual deployment.  

- **🏭 GitOps Branch (Production)**  
   Tailored for **real-world production**. Every code change triggers CI/CD pipelines that build Docker images, push to private ECR, and auto-deploy via ArgoCD.  

---

## How to Deploy It Yourself
1. Install prerequisites → AWS CLI, Terraform, kubectl, Docker, Helm  
2. Configure AWS credentials  
3. Clone the repository  
4. Run **Terraform Phase 1** → to create VPC + EKS  
5. Update kubeconfig  
6. Run **Terraform Phase 2** → to deploy GitOps stack + app  
7. Get ingress IP → access the application in your browser 🎉  

---

## Lessons Learned
- **GitOps is a game-changer** → once configured, deployments feel effortless.  
- **Over-engineering helps learning** → multiple services, multiple databases, multiple workflows.  
- **Branching strategy matters** → separating “demo” from “production” keeps things clean.  

---

## Conclusion
The **Retail Store Sample App** isn’t just an e-commerce app — it’s a **blueprint for cloud-native development**.  

Whether you’re a beginner exploring Kubernetes or an engineer setting up GitOps workflows, this project provides a practical playground.  


---
