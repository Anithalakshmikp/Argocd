#!/bin/bash
set -e

# ==========================================
# One-Click Deployment Script
# ==========================================

# 1️⃣ Pull latest code from GitHub
echo -e "\n🔄 Pulling latest code from GitHub..."
git pull origin master

# 2️⃣ Build Docker image
echo -e "\n🐳 Building Docker image..."
docker build -t anithalakshmikshmi/hello-k3s:latest ./hello-k3s

# 3️⃣ Push Docker image to DockerHub
echo -e "\n📤 Pushing Docker image to DockerHub..."
docker push anithalakshmikshmi/hello-k3s:latest

# 4️⃣ Apply Kubernetes manifests
echo -e "\n☸ Applying Kubernetes manifests..."
kubectl apply -f hello-k3s/k8s/

# 5️⃣ Trigger ArgoCD sync
echo -e "\n🔁 Triggering ArgoCD sync..."
argocd app sync hello-k3s --grpc-web

# ✅ Deployment complete
echo -e "\n🎉 Deployment completed successfully!"
