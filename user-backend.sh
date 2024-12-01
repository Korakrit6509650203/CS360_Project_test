echo "Starting Docker pull and run..."

sudo docker pull korakrit/cs360_backend_image_test:latest
sudo docker run -p 1337:1337 --name cs360_backend_container korakrit/cs360_backend_image_test:latest

echo "Docker containers are running."