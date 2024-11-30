#!/bin/bash
# Update the package manager and install Docker
sudo yum update -y
sudo yum install -y docker

# Start Docker and enable it to start on boot
sudo service docker start
sudo systemctl enable docker

# Add the ec2-user to the Docker group (so you can run Docker commands without sudo)
sudo usermod -aG docker ec2-user


sudo docker pull korakrit/cs360_frontend_image_test:latest
docker run -d -p 3000:3000 --name cs360_frontend_container korakrit/cs360_frontend_image_test:latest

sudo docker pull korakrit/cs360_backtend_image_test:latest
docker run -d -p 1337:1337 --name cs360_backtend_container korakrit/cs360_backtend_image_test:latest