#!/bin/sh

# Colors.
GREEN='\e[0;32m'
BLUE='\e[0;34m'
END='\e[0;0m'

echo "user42" | sudo -S adduser $USER docker
echo "user42" | sudo -S chmod 666 /var/run/docker.sock
echo "user42" | sudo -S ufw allow 20/tcp


# Kill all processes.
minikube delete
killall -TERM kubectl minikube VBoxHeadless

# Start minikube.
minikube --driver=docker start

# Use the docker daemon from minikube.
eval $(minikube docker-env)

IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
printf "Minikube IP: ${IP}"

# Build docker images.
echo "${GREEN}Docker build init${END}"
docker build -t my_nginx src/nginx > /dev/null 2>&1
docker build -t my_wordpress src/wordpress > /dev/null 2>&1
docker build -t my_mysql src/mysql > /dev/null 2>&1
docker build -t my_phpmyadmin src/phpmyadmin > /dev/null 2>&1
docker build -t my_ftps src/ftps > /dev/null 2>&1
docker build -t my_grafana src/grafana > /dev/null 2>&1
docker build -t my_influxdb src/influxdb > /dev/null 2>&1
echo "${BLUE}Docker build completed${END}"

# create yaml resources.
echo "${GREEN}Deploy init${END}"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl apply -f src/metallb/metallb.yaml
kubectl apply -f src/nginx/nginx.yaml
kubectl apply -f src/mysql/mysql.yaml
kubectl apply -f src/ftps/ftps.yaml
kubectl apply -f src/phpmyadmin/phpmyadmin.yaml
kubectl apply -f src/wordpress/wordpress.yaml
kubectl apply -f src/grafana/grafana.yaml
kubectl apply -f src/influxdb/influxdb.yaml
echo "${BLUE}Deploy completed${END}"

# Setup metalLB secret.
kubectl create secret generic -n metallb-system memberlist  --from-literal=secretkey="$(openssl rand -base64 128)"

# Enable addons.
minikube addons enable dashboard
minikube addons enable metrics-server

# Open dashboard.
minikube dashboard
