locals {
  cluster_name     = "grafana-lgtm"
  kind_api_version = "kind.x-k8s.io/v1alpha4"
  node_image       = "kindest/node:v1.32.1"
  wait_for_ready   = true

  grafana_chart_version = "8.11.4"
  loki_chart_version    = "6.29.0"
  tempo_chart_version   = "1.20.0"
  alloy_chart_version   = "1.0.1"
}
