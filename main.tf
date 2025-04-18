resource "kind_cluster" "default" {
  name            = local.cluster_name
  node_image      = local.node_image
  wait_for_ready  = local.wait_for_ready
  kubeconfig_path = pathexpand("/tmp/kind-config")

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
      extra_port_mappings {
        container_port = 80
        host_port      = 80
      }
    }
    node {
      role = "worker"
    }
  }
}

resource "helm_release" "grafana" {
  name             = "grafana"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "grafana"
  create_namespace = true
  namespace        = "grafana"
  version          = local.grafana_chart_version
  values           = [file("${path.module}/values/grafana.yaml")]

  depends_on = [kind_cluster.default]
}

resource "helm_release" "loki" {
  name             = "loki"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki"
  create_namespace = true
  namespace        = "loki"
  version          = local.loki_chart_version
  values           = [file("${path.module}/values/loki.yaml")]

  depends_on = [kind_cluster.default]
}
