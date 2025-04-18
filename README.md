## Grafana LGTM

Open source tools designed for monitoring, observability, and visualization.

* [L]oki

* [G]rafana

* [T]empo

* [M]imir

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
