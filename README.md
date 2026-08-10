# 🎓 DevOps Mini Projects — Final Week

Two mini-projects designed for a classroom of working professionals, using
only **free, local tools** — no cloud bill, no credit card. Each project
spans 2 classes and builds on the course's core skills (Git, Docker, CI/CD,
Kubernetes, IaC, Monitoring).

| | Project 1 | Project 2 |
|---|---|---|
| **Name** | [AutoDeploy](./project1-autodeploy/) — CI/CD Pipeline for a Dockerized App | [ObserveOps](./project2-observeops/) — Infrastructure as Code + Monitoring Dashboard |
| **Classes** | Class 1 & 2 | Class 3 & 4 |
| **Core Skills** | Git, Docker, GitHub Actions, Kubernetes | Terraform, Docker, Prometheus, Grafana |
| **Concept Covered** | Continuous Integration → Continuous Deployment | Infrastructure as Code → Observability |

**Why these two together?** They simulate a real DevOps lifecycle:
> Code → Build → Test → Deploy (Project 1) → Provision Infra → Monitor It (Project 2)

## 📁 Folder structure

```
devops-mini-projects/
├── README.md                          <- you are here
├── PREREQUISITES.md                   <- give this to students 1 week early
├── project1-autodeploy/
│   ├── README.md                      <- full Class 1 & 2 walkthrough
│   ├── app.py                         <- Flask app
│   ├── requirements.txt
│   ├── Dockerfile
│   ├── .dockerignore
│   ├── deployment.yaml                <- Kubernetes manifests
│   └── .github/workflows/ci-cd.yml    <- GitHub Actions pipeline
└── project2-observeops/
    ├── README.md                      <- full Class 3 & 4 walkthrough
    ├── main.tf                        <- Terraform config
    └── prometheus.yml                 <- Prometheus scrape config
```

## 🚀 How to use this with students

1. Send them `PREREQUISITES.md` **one week before** the last week starts.
2. Zip this whole folder (or push it to a shared GitHub repo) and hand it out
   on Day 1 of the last week.
3. Follow `project1-autodeploy/README.md` for Classes 1–2.
4. Follow `project2-observeops/README.md` for Classes 3–4.
5. Use the final cheat sheet below on the last day as a recap.

## 🎓 Final Wrap-Up Cheat Sheet

```bash
# Project 1 — CI/CD
docker build -t app . && docker run -p 5000:5000 app
minikube start && kubectl apply -f deployment.yaml
kubectl get pods
kubectl get svc
minikube service autodeploy-service --url

# Project 2 — IaC + Monitoring
terraform init
terraform plan
terraform apply
docker ps
# Prometheus: http://localhost:9090   Grafana: http://localhost:3000
terraform destroy
```
