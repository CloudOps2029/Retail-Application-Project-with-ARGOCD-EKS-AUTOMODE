# =============================================================================
# ARGOCD INSTALLATION AND CONFIGURATION
# =============================================================================

# Wait for the cluster and add-ons to be ready
resource "time_sleep" "wait_for_cluster" {
  create_duration = "30s"
  depends_on = [
    module.retail_app_eks,
    module.eks_addons
  ]
}

# =============================================================================
# ARGOCD HELM INSTALLATION
# =============================================================================

resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = var.argocd_namespace
  create_namespace = true

  depends_on = [
    time_sleep.wait_for_cluster,
    module.eks_addons
  ]

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = var.argocd_chart_version

  values = [
    yamlencode({
      server = {
        service = { type = "ClusterIP" }
        ingress = { enabled = false }
        extraArgs = ["--insecure"]
      }
      controller = {
        resources = {
          requests = { cpu = "100m", memory = "128Mi" }
          limits   = { cpu = "500m", memory = "512Mi" }
        }
      }
      repoServer = {
        resources = {
          requests = { cpu = "50m", memory = "64Mi" }
          limits   = { cpu = "200m", memory = "256Mi" }
        }
      }
      redis = {
        resources = {
          requests = { cpu = "50m", memory = "64Mi" }
          limits   = { cpu = "200m", memory = "128Mi" }
        }
      }
    })
  ]
}

# =============================================================================
# WAIT FOR ARGOCD TO BE READY
# =============================================================================

resource "time_sleep" "wait_for_argocd" {
  create_duration = "60s"
  depends_on      = [helm_release.argocd]
}

# =============================================================================
# DEPLOY ARGOCD APPLICATIONS
# =============================================================================

resource "null_resource" "argocd_apps" {
  depends_on = [time_sleep.wait_for_argocd]

  provisioner "local-exec" {
    command = <<-EOT
      echo "Deploying ArgoCD projects and applications..."
      kubectl apply -n ${var.argocd_namespace} -f ${path.module}/../argocd/projects/
      kubectl apply -n ${var.argocd_namespace} -f ${path.module}/../argocd/applications/
      echo "ArgoCD applications deployed successfully!"
    EOT
  }

  triggers = {
    argocd_version = var.argocd_chart_version
    timestamp      = timestamp()
  }
}
