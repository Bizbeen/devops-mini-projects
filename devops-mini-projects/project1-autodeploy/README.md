# 🚀 Project 1: AutoDeploy — CI/CD Pipeline with Docker + GitHub Actions + Kubernetes

## 🎯 Learning Objective
Take a simple web app, containerize it, and build a pipeline that **automatically
builds, tests, and deploys it** every time code is pushed to GitHub — no manual steps.

## 🏗️ Architecture

```
 Developer Laptop                GitHub                    Local Machine
┌────────────────┐        ┌───────────────────┐       ┌──────────────────────┐
│  1. Write Code │─push──▶│  2. GitHub Repo    │       │                      │
│  (Flask App)   │        │                    │       │                      │
└────────────────┘        │  3. GitHub Actions │       │                      │
                          │     (CI/CD runner) │       │                      │
                          │  ┌──────────────┐  │       │                      │
                          │  │ Build Image  │  │       │                      │
                          │  │ Run Tests    │  │       │                      │
                          │  │ Push to      │──┼──────▶│  4. Docker Hub       │
                          │  │ Docker Hub   │  │       │     (Image Registry) │
                          │  └──────────────┘  │       │                      │
                          └───────────────────┘        │  5. Minikube (K8s)   │
                                                        │     pulls image &    │
                                                        │     deploys pod ───▶ │──▶ App Live
                                                        └──────────────────────┘
```

**Flow:** Student writes code → pushes to GitHub → GitHub Actions automatically
builds a Docker image, tests it, and pushes it to Docker Hub → Kubernetes pulls
that image and runs the app.

## 📋 Prerequisites
- Git, Docker Desktop, kubectl, Minikube installed (see root `PREREQUISITES.md`)
- A free [Docker Hub](https://hub.docker.com) account
- A new **empty public GitHub repo** created for this project

## 📂 Files in this folder
| File | Purpose |
|---|---|
| `app.py` | The Flask app being deployed |
| `requirements.txt` | Python dependency (flask) |
| `Dockerfile` | Instructions to containerize the app |
| `.github/workflows/ci-cd.yml` | GitHub Actions pipeline (auto build & push) |
| `deployment.yaml` | Kubernetes Deployment + Service manifests |

---

## 🗓️ CLASS 1 — Dockerize & Push

1. **Copy this folder's contents** into a new git repo:
   ```bash
   cd project1-autodeploy
   git init
   git add .
   git commit -m "initial app"
   git remote add origin https://github.com/<your-username>/autodeploy-app.git
   git push -u origin main
   ```

2. **Build & run locally:**
   ```bash
   docker build -t autodeploy-app .
   docker run -p 5000:5000 autodeploy-app
   # open http://localhost:5000
   ```
   Explore: `docker ps`, `docker images`, `docker logs <container>`

3. **Push image to Docker Hub manually** (so students see the manual way before automating):
   ```bash
   docker login
   docker tag autodeploy-app <dockerhub-username>/autodeploy-app:v1
   docker push <dockerhub-username>/autodeploy-app:v1
   ```

4. **Homework:** Verify the image appears on hub.docker.com.

---

## 🗓️ CLASS 2 — Automate with GitHub Actions & Deploy to Kubernetes

1. **Add Docker Hub credentials as GitHub Secrets:**
   Repo → Settings → Secrets and variables → Actions → New repository secret
   - `DOCKER_USERNAME`
   - `DOCKER_PASSWORD`

2. **Push the workflow file** (already included at `.github/workflows/ci-cd.yml`):
   ```bash
   git add .github/workflows/ci-cd.yml
   git commit -m "add CI/CD pipeline"
   git push
   ```
   Watch it run live under the repo's **Actions** tab. 🎉

3. **Start a local Kubernetes cluster:**
   ```bash
   minikube start
   kubectl get nodes
   ```

4. **Edit `deployment.yaml`** — replace `<dockerhub-username>` with the real Docker Hub username.

5. **Deploy & verify:**
   ```bash
   kubectl apply -f deployment.yaml
   kubectl get pods
   kubectl get svc
   minikube service autodeploy-service --url
   # open the printed URL -> app is live!
   ```

6. **Full circle demo:** Edit the message in `app.py`, push to GitHub, watch the
   pipeline auto-rebuild the image, then run:
   ```bash
   kubectl rollout restart deployment autodeploy-app
   ```
   to pull the new image and show the updated app.

## 🛠 Common Issues
- Docker Desktop not running → Minikube fails to start
- Port 5000 already in use on Mac (AirPlay Receiver) → use `-p 5001:5000`
- GitHub Actions secret names are case-sensitive — double check spelling

## ✅ Assessment Idea
Ask each student to change the app's message, push the code, and show the
pipeline rebuild + redeploy live — grade on understanding, not perfection.
