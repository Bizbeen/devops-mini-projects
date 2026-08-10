# 📊 Project 2: ObserveOps — Infrastructure as Code + Monitoring Dashboard

## 🎯 Learning Objective
Use **Terraform** to provision infrastructure as code (no manual `docker run`
commands), then set up **Prometheus + Grafana** to monitor it — introducing
observability, a critical real-world DevOps skill.

> 💡 **Cost-free trick:** We use Terraform's **Docker provider** instead of
> AWS/Azure. This teaches real IaC syntax and workflow without needing a cloud
> account or credit card — perfect for a classroom.

## 🏗️ Architecture

```
┌─────────────────┐
│   Terraform      │  (Infrastructure as Code)
│   main.tf        │
└────────┬─────────┘
         │ terraform apply
         ▼
┌───────────────────────────────────────────────────┐
│                Docker Engine (local)                │
│                                                       │
│  ┌───────────────┐   scrapes    ┌─────────────────┐ │
│  │  App Container │◀────────────│   Prometheus     │ │
│  │  (autodeploy)  │   metrics   │   Container      │ │
│  └───────────────┘              └────────┬────────┘ │
│                                           │ data source│
│                                           ▼           │
│                                  ┌─────────────────┐ │
│                                  │    Grafana       │ │
│                                  │    Container     │ │
│                                  │  (Dashboards)     │ │
│                                  └─────────────────┘ │
└───────────────────────────────────────────────────┘
         ▲
         │ view in browser
   ┌──────────┐
   │  Student  │
   └──────────┘
```

**Flow:** Terraform code defines "I want an app container, a Prometheus
container, and a Grafana container running." Terraform creates them.
Prometheus continuously pulls metrics from the app. Grafana visualizes those
metrics as graphs/dashboards.

## 📋 Prerequisites
- Terraform CLI installed (see root `PREREQUISITES.md`)
- Docker Desktop running
- **Project 1 completed** — this project reuses the `autodeploy-app` image
  pushed to Docker Hub in Project 1 (or use any Docker Hub image you like)

## 📂 Files in this folder
| File | Purpose |
|---|---|
| `main.tf` | Terraform config — defines app, Prometheus & Grafana containers |
| `prometheus.yml` | Prometheus scrape config — tells it where to pull metrics from |

---

## 🗓️ CLASS 3 — Provision Infrastructure with Terraform

1. **Edit `main.tf`** — replace `<dockerhub-username>` with the real Docker
   Hub username from Project 1.

2. **Run the Terraform lifecycle:**
   ```bash
   cd project2-observeops
   terraform init      # downloads the docker provider plugin
   terraform plan       # shows what WILL be created (dry run)
   terraform apply       # actually creates it (type "yes")
   ```
   🎓 Teaching moment: this is the exact same workflow used with AWS/Azure —
   only the provider block changes.

3. **Verify, then destroy & recreate:**
   ```bash
   docker ps                  # see the container Terraform created
   terraform destroy           # tear it all down
   terraform apply             # rebuild it in seconds — that's the power of IaC
   ```

4. **Homework:** Add a second `docker_container` resource (e.g. Postgres or
   Redis) to practice repetition. (Comment out the Prometheus/Grafana blocks
   first if you want to isolate this exercise — they're used in Class 4.)

---

## 🗓️ CLASS 4 — Add Monitoring with Prometheus & Grafana

`main.tf` already includes the Prometheus and Grafana resources — just apply:

```bash
terraform apply
docker ps    # should show 3 containers: app, prometheus, grafana
```

1. **Open in browser:**
   - Prometheus → `http://localhost:9090` → check the **Targets** page,
     confirm the `app` job shows "UP"
   - Grafana → `http://localhost:3000` (login `admin` / `admin`)

2. **Configure Grafana:**
   - Add Data Source → Prometheus → URL: `http://prometheus:9090`
   - Create Dashboard → New Panel → Query: `up` (or a container CPU/memory metric)
   - Save dashboard as **"ObserveOps Dashboard"**

3. **Generate traffic & watch the dashboard live:**
   ```bash
   for i in {1..100}; do curl localhost:5000; done
   ```
   Watch the Grafana graph move in real time. 🎓 This is the "aha" moment —
   students SEE monitoring work.

4. **Wrap-up — destroy everything with one command:**
   ```bash
   terraform destroy
   ```
   Reinforces the core IaC lesson: *everything is disposable and reproducible.*

## 🛠 Common Issues
- `host.docker.internal` doesn't resolve on Linux — add this to the app
  container's Terraform resource:
  ```hcl
  host {
    host = "host.docker.internal"
    ip   = "host-gateway"
  }
  ```
- Grafana's port 3000 may conflict with other dev tools already running
- Pin provider versions (already done in `main.tf`) to avoid version mismatch errors

## ✅ Assessment Idea
Have each student add one more metric panel to their Grafana dashboard and
explain what it shows — tests real understanding vs. copy-paste.
