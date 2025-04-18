resource "kind_cluster" "default" {
  name           = local.cluster_name
  node_image     = local.node_image
  wait_for_ready = local.wait_for_ready

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
