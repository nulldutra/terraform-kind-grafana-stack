## Grafana stack

Open source tools designed for monitoring, observability, and visualization.

* Alloy

* Loki

* Grafana

* Prometheus

* Tempo

<hr>

## Requirements

* Docker

* Kind

* Terraform

## Deploying

```sh
terraform init && terraform apply
```

## Accessing cluster

We need to set the environment variable `KUBECONFIG` to point to the config.

```sh
export KUBECONFIG=/tmp/kind-config
```

## Accessing applications

### Grafana

```sh
kubectl port-forward -n grafana svc/grafana 3000:80
```

### Prometheus

```sh
kubectl port-forward -n prometheus svc/prometheus-server 9090:80
```
