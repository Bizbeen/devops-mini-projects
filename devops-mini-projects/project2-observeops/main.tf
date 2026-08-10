# ⚠️ Before applying: replace <dockerhub-username> below with your actual Docker Hub username
# (the image built & pushed in Project 1)

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# ---------------------------------------------------------------------------
# CLASS 3: App container provisioned via Terraform (Infrastructure as Code)
# ---------------------------------------------------------------------------
resource "docker_image" "app" {
  name = "<dockerhub-username>/autodeploy-app:latest"
}

resource "docker_container" "app" {
  name  = "autodeploy-container"
  image = docker_image.app.image_id
  ports {
    internal = 5000
    external = 5000
  }
}

# ---------------------------------------------------------------------------
# CLASS 4: Monitoring stack — Prometheus + Grafana
# ---------------------------------------------------------------------------
resource "docker_image" "prometheus" {
  name = "prom/prometheus:latest"
}

resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.prometheus.image_id
  ports {
    internal = 9090
    external = 9090
  }
  volumes {
    host_path      = "${path.cwd}/prometheus.yml"
    container_path = "/etc/prometheus/prometheus.yml"
  }
}

resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
}

resource "docker_container" "grafana" {
  name  = "grafana"
  image = docker_image.grafana.image_id
  ports {
    internal = 3000
    external = 3000
  }
}
