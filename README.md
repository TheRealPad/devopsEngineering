![Latest Release](https://img.shields.io/github/v/release/TheRealPad/devopsEngineering?label=latest%20release)
![Build Status](https://github.com/TheRealPad/devopsEngineering/actions/workflows/ci.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Issues](https://img.shields.io/github/issues/TheRealPad/devopsEngineering)
![Repo Size](https://img.shields.io/github/repo-size/TheRealPad/devopsEngineering)
![Contributors](https://img.shields.io/github/contributors/TheRealPad/devopsEngineering)
![Last Commit](https://img.shields.io/github/last-commit/TheRealPad/devopsEngineering)

# DevOps Engineering

Hello I'm Pierre-Alexandre Delgado, a software engineer from France and this repository will contain a self taught formation in the DevOps Engineering.

- [ ] [Git/Github](#gitgithub)
- [x] [Docker](#docker)
- [ ] [Kubernetes](#kubernetes)
- [ ] [Terraform](#terraform)
- [ ] [CI/CD](#cicd-1)
- [ ] [Observabilite & Security](#observabilite--security)
- [ ] [Cloud Providers](#cloud-providers)

## Git/Github

Create a Git workflow for code review

### Issues and Pull requests

You can find templates for pull requests and issues in the **.github/**

### Branch protection

There are branch protections on **main** and **develop** to avoid push on it or branch deletion

### Pipeline

#### CI/CD

When you push or make a PR to main or develop, this pipeline automatically analyse, test, build and deploy the code

#### Release

When you create a tag in the form "v{tag_version}" the pipeline automatically generate the release

```bash
# Exemple
git tag -a v1.0.1 -m "Release version 1.0.1"
git push origin v1.0.1
```

## Docker

Dockerise an application and it's services

### How to use

It's a poll application, you can run the app with the following command:
```
docker compose up --build
```

You need these ports to be free: 5001, 5050

You can access the [poll](http://localhost:5050/) and the [results](http://localhost:5001/)

## Kubernetes

Deploy all app's services with Helm on minikube

## Terraform
Create an infra on AWS (EC2, S3, VPC) with Terraform

## CI/CD

Full pipeline to build Docker + deploy on Kubernetes

## Observabilite & Security

Create a stack for monitoring + scannnig the Docker image

## Cloud Providers

Deploy the app cluster GKE with Terraform
