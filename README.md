# Cloud Migration Infrastructure

A production-grade AWS infrastructure project that provisions an EKS cluster with Prometheus monitoring using Terraform, GitHub Actions, and Helm.

## Tech Stack
- Terraform
- AWS EKS, VPC, EC2, CloudWatch, KMS
- GitHub Actions
- Helm
- Prometheus & Grafana

## Architecture
- **VPC** — Custom VPC (10.0.0.0/16) with public and private subnets across 2 availability zones
- **EKS Cluster** — Kubernetes 1.32 with managed node groups (1–3 t3.medium instances)
- **Cluster Addons** — CoreDNS, kube-proxy, VPC-CNI
- **Prometheus Monitoring** — kube-prometheus-stack deployed via Helm

## Pipeline
The GitHub Actions pipeline supports two actions via workflow_dispatch:

| Action | Description |
|---|---|
| `apply` | Provisions VPC, EKS cluster, node groups, and deploys Prometheus |
| `destroy` | Tears down all infrastructure |

## GitHub Secrets Required
| Secret | Description |
|---|---|
| `AWS_ACCESS_KEY_ID` | IAM user access key |
| `AWS_SECRET_ACCESS_KEY` | IAM user secret key |
| `AWS_REGION` | AWS region (e.g. us-east-1) |

## Setup
1. Create S3 state bucket
2. Add GitHub secrets
3. Go to Actions → Terraform Pipeline → Run workflow → apply

## Cleanup
Go to Actions → Terraform Pipeline → Run workflow → destroy
