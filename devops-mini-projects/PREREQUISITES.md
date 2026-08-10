# 🧰 Common Prerequisites (Install Before Week Starts)

Share this checklist with students **one week before class** so setup issues
don't eat into teaching time.

## Hardware/OS minimum
- 8GB RAM minimum (16GB comfortable), 20GB free disk
- Windows 10/11 (with WSL2), macOS, or Linux

## Software checklist

| Tool | Purpose | Install |
|---|---|---|
| Git | Version control | https://git-scm.com |
| GitHub account | Remote repo + CI/CD | https://github.com/join |
| Docker Desktop | Containers | https://docker.com/products/docker-desktop |
| VS Code | Editor | https://code.visualstudio.com |
| kubectl | Kubernetes CLI | `brew install kubectl` (Mac) / `choco install kubernetes-cli` (Windows) / `apt install kubectl` (Linux) |
| Minikube | Local Kubernetes cluster | `brew install minikube` (Mac) / `choco install minikube` (Windows) / see minikube.sigs.k8s.io (Linux) |
| Terraform CLI | Infrastructure as Code | `brew install terraform` (Mac) / `choco install terraform` (Windows) / see terraform.io/downloads (Linux) |
| Docker Hub account | Image registry | https://hub.docker.com |

## Verify installation

Run these commands — every student should get a version number or success
message for all of them:

```bash
git --version
docker --version
docker run hello-world
kubectl version --client
minikube version
terraform -version
```

✅ **If all 6 commands succeed, the student is ready for Class 1.**

## Project-specific extras
- **Project 1 (AutoDeploy):** free Docker Hub account + an empty public GitHub repo
- **Project 2 (ObserveOps):** Project 1 completed (reuses its Docker Hub image)
