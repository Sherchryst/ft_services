#!/bin/sh

# Colors.
GREEN='\e[0;32m'
BLUE='\e[0;34m'
END='\e[0;0m'

# Kill all processes.
minikube delete
killall -TERM kubectl minikube VBoxHeadless

# Start minikube.
minikube start --driver=docker

# Use the docker daemon from minikube.
eval $(minikube docker-env)

# Build docker images.
# ""> /dev/null 2>&1" redirects the output of your program to /dev/null. Include both the Standard Error and Standard Out
# ">" is for redirect. "/dev/null" is a black hole where any data sent, will be discarded
# "2" is the file descriptor for Standard Error. "1" is the file descriptor for Standard Out.
# "&" is the symbol for file descriptor (without it, the following 1 would be considered a filename).
echo "${GREEN}Docker build init${END}"
docker build -t my_nginx src/nginx > /dev/null 2>&1
docker build -t my_wordpress src/wordpress > /dev/null 2>&1
docker build -t my_mysql src/mysql > /dev/null 2>&1
docker build -t my_phpmyadmin src/phpmyadmin > /dev/null 2>&1
docker build -t my_ftps src/ftps > /dev/null 2>&1
#docker build -t my_grafana src/grafana > /dev/null 2>&1
#docker build -t my_influxdb src/influxdb > /dev/null 2>&1
echo "${BLUE}Docker build completed${END}"

# Apply yaml resources.
echo "${GREEN}Deploy init${END}"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl apply -f src/metallb/metallb.yaml
kubectl apply -f src/nginx/nginx.yaml
kubectl apply -f src/mysql/mysql.yaml
kubectl apply -f src/ftps/ftps.yaml
kubectl apply -f src/phpmyadmin/phpmyadmin.yaml
kubectl apply -f src/wordpress/wordpress.yaml
#kubectl apply -f src/grafana/grafana.yaml
#kubectl apply -f src/influxdb/influxdb.yaml
echo "${BLUE}Deploy completed${END}"

# Setup metalLB secret.
kubectl create secret generic -n metallb-system memberlist  --from-literal=secretkey="$(openssl rand -base64 128)"

# Enable addons.
minikube addons enable dashboard
minikube addons enable ingress
minikube addons enable metrics-server

# Open dashboard.
minikube dashboard