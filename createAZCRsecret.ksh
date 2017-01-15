export DOCKER_REGISTRY_SERVER=YOURREGSERVER
export DOCKER_USER=YOURUSER
export DOCKER_PASSWORD=YOURPASSWORD
export DOCKER_EMAIL=YOUREMAIL
kubectl create secret docker-registry myregistrykey --docker-server=$DOCKER_REGISTRY_SERVER --docker-username=$DOCKER_USER --docker-password=$DOCKER_PASSWORD --docker-email=$DOCKER_EMAIL
