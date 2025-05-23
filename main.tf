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
      extra_port_mappings {
        container_port = 443
        host_port      = 443
      }
    }

    node {
      role = "worker"
    }
  }
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

resource "helm_release" "tempo" {
  name             = "tempo"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "tempo"
  create_namespace = true
  namespace        = "tempo"
  version          = local.tempo_chart_version
  values           = [file("${path.module}/values/tempo.yaml")]

  depends_on = [kind_cluster.default]
}

resource "helm_release" "alloy" {
  name             = "alloy"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "alloy"
  create_namespace = true
  namespace        = "alloy"
  version          = local.alloy_chart_version
  values           = [file("${path.module}/values/alloy.yaml")]

  depends_on = [kind_cluster.default]
}

resource "helm_release" "prometheus" {
  name             = "prometheus"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "prometheus"
  create_namespace = true
  namespace        = "prometheus"
  version          = local.prometheus_chart_version
  values           = [file("${path.module}/values/prometheus.yaml")]

  depends_on = [kind_cluster.default]
}
