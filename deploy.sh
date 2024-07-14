#!/bin/bash

# Update package database
sudo apt-get update -y

# Install necessary prerequisites
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker APT repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update package database with Docker packages from the newly added repo
sudo apt-get update -y

# Install Docker
sudo apt-get install docker-ce -y

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Set environment variables
export AWS_PUBLIC_REPO_IMAGE="public.ecr.aws/your-repo/your-image:latest"
export API_ENDPOINT="http://your-api-endpoint-ip:port/your-api-path"

# Pull Docker image from AWS public repository
sudo docker pull $AWS_PUBLIC_REPO_IMAGE

# Run Docker container
sudo docker run -d --name my-container $AWS_PUBLIC_REPO_IMAGE

# Get server information
SERVER_INFO=$(uname -a)

# Make API request with server information
curl -X POST -H "Content-Type: application/json" -d "{\"server_info\": \"$SERVER_INFO\"}" $API_ENDPOINT

# Confirm installation
echo "Docker installation and setup complete."
echo "Docker image pulled: $AWS_PUBLIC_REPO_IMAGE"
echo "API request sent to: $API_ENDPOINT"
