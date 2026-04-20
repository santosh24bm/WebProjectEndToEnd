#!/bin/bash

# Google Cloud Run Deployment Script
# Usage: ./deploy.sh <PROJECT_ID> <SERVICE_NAME> <REGION>

PROJECT_ID=${1:-"your-project-id"}
SERVICE_NAME=${2:-"springboot-app"}
REGION=${3:-"us-central1"}
IMAGE_NAME="springboot-app"

echo "=== Spring Boot Cloud Run Deployment ==="
echo "Project ID: $PROJECT_ID"
echo "Service Name: $SERVICE_NAME"
echo "Region: $REGION"
echo ""

# Set project
echo "Setting Google Cloud project..."
gcloud config set project $PROJECT_ID

# Build Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME:latest .

# Tag for Google Container Registry
echo "Tagging image for GCR..."
docker tag $IMAGE_NAME:latest gcr.io/$PROJECT_ID/$IMAGE_NAME:latest

# Push to GCR
echo "Pushing image to Google Container Registry..."
docker push gcr.io/$PROJECT_ID/$IMAGE_NAME:latest

# Deploy to Cloud Run
echo "Deploying to Cloud Run..."
gcloud run deploy $SERVICE_NAME \
  --image gcr.io/$PROJECT_ID/$IMAGE_NAME:latest \
  --platform managed \
  --region $REGION \
  --allow-unauthenticated \
  --port 8080 \
  --memory 512Mi \
  --cpu 1 \
  --timeout 3600

echo ""
echo "=== Deployment Complete ==="
echo "Your service is now available at:"
gcloud run services describe $SERVICE_NAME --region $REGION --format='value(status.url)'
