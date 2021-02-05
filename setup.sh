#!/bin/sh

# Colors.
GREEN='\e[0;32m'
BLUE='\e[0;34m'
END='\e[0;0m'

# Kill all processes.
minikube delete
killall -TERM kubectl minikube VBoxHeadless

# Start minikube.
minikube --vm-driver=docker start

# Use the docker daemon from minikube.
eval $(minikube docker-env)

IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
printf "Minikube IP: ${IP}"

# Build docker images.
echo "${GREEN}Docker build init${END}"
docker build -t my_nginx src/nginx 
docker build -t my_wordpress src/wordpress --build-arg IP=${IP}
docker build -t my_mysql src/mysql --build-arg IP=${IP}
docker build -t my_phpmyadmin src/phpmyadmin --build-arg IP=${IP}
docker build -t my_ftps src/ftps --build-arg IP=${IP}
docker build -t my_grafana src/grafana 
docker build -t my_influxdb src/influxdb 
echo "${BLUE}Docker build completed${END}"

# create yaml resources.
echo "${GREEN}Deploy init${END}"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.3/manifests/metallb.yaml
kubectl apply -f src/metallb/metallb.yaml
kubectl create -f src/nginx/nginx.yaml
kubectl create -f src/mysql/mysql.yaml
kubectl create -f src/ftps/ftps.yaml
kubectl create -f src/phpmyadmin/phpmyadmin.yaml
kubectl create -f src/wordpress/wordpress.yaml
kubectl create -f src/grafana/grafana.yaml
kubectl create -f src/influxdb/influxdb.yaml
echo "${BLUE}Deploy completed${END}"

# Setup metalLB secret.
kubectl create secret generic -n metallb-system memberlist  --from-literal=secretkey="$(openssl rand -base64 128)"

# Enable addons.
minikube addons enable dashboard
minikube addons enable ingress
minikube addons enable metrics-server


echo "Opening the network in your browser"
xdg-open http://$IP

# Open dashboard.
minikube dashboard