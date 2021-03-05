# ft_services
42 cursus project, about kubernetes and docker.
## How To Use

### Installation

> Step 1: Update System and Install Required Packages

```shell
# Before installing any software, you need to update and upgrade the system you are working on.
sudo apt-get update -y
sudo apt-get upgrade -y
# Also, make sure to install (or check whether you already have) the following required packages:
sudo apt-get install curl
sudo apt-get install apt-transport-https
sudo apt-get install ca-certificates
sudo apt-get install software-properties-common
```

> Step 2: Install Docker

```shell
# First add the GPG key for the official Docker repository to your system.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# Add the Docker repository to APT sources.
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
# Next, update the package database with the Docker packages from the newly added repo.
sudo apt update
# Make sure you are about to install from the Docker repo instead of the default Ubuntu repo.
apt-cache policy docker-cesudo
# Finally, install Docker.
sudo apt-get install docker-ce
# Docker should now be installed, the daemon started, and the process enabled to start on boot.
# Check that it’s running.
sudo systemctl status docker
# To avoid typing sudo whenever you run the docker command, add your username to the docker group:
sudo usermod -aG docker $(whoami);
# To apply the new group membership, log out of the server and back in, or type the following.
su - ${USER}
# You will be prompted to enter your user’s password to continue.
# Confirm that your user is now added to the docker group by typing.
id -nG
# Using docker consists of passing it a chain of options and commands followed by arguments.
docker [option] [command] [arguments]
# To view all available subcommands, type:
docker
```

> Step 3: Install VirtualBox Hypervisor and FileZilla
```shell
# You need a virtual machine in which you can set up your single node cluster with Minikube.
# You can use VirtualBox.
# Confirm the installation with "y" and hit "Enter".
# Next, the licence agreement appears on the screen.nPress "Tab" and then "Enter" to continue.
# The installer asks you to agree with the terms of the VirtualBox PUEL license by selecting "Yes".
# Note: For the VirtualBox hypervisor to work, hardware virtualization must be enabled in your system BIOS.
sudo apt install virtualbox virtualbox-ext-pack
# FileZilla is the open source FTP client program.
# It allows us to securely transfer files from the local computer to the remote computer.
sudo apt-get install filezilla
```

> Step 4: Install Minikube
```shell
# With VirtualBox set up, move on to installing Minikube on your Ubuntu system.
# First, download the latest Minikube binary using the wget command.
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
# Copy the downloaded file and store it into the /usr/local/bin/minikube directory.
sudo cp minikube-linux-amd64 /usr/local/bin/minikube
# Next, give the file executive permission using the chmod command.
sudo chmod 755 /usr/local/bin/minikube
# Finally, verify you have successfully installed Minikube by checking the version of the software.
minikube version
```

> Step 5: Install Kubectl
```shell
# To deploy and manage clusters, you need to install kubectl, the official command line tool for Kubernetes.
# Download kubectl.
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
# Make the binary executable.
chmod +x ./kubectl
# Then, move the binary into your path.
sudo mv ./kubectl /usr/local/bin/kubectl
# Verify the installation by checking the version of your kubectl instance.
kubectl version -o json
```

> Step 6: Start Minikube
```shell
# Note: Your VM has to have at least 2 CPU cores avalaible.
# It doesn't by default, so go into Virtualbox settings and add another core to it.
# Once you have set up all the required software, you are ready to start Minikube.
minikube start --vm-driver=virtualbox
# First, the system downloads the Minikube ISO file from an online source and the localkube binary.
# Then, creates a VM in VirtualBox within which it starts and configures a single node cluster.
```

> FTPs verification
```
openssl s_client -connect 192.168.49.3:21 -starttls ftp -servername 192.168.49.3
```

> Common Minikube Commands
```shell
# To see the kubectl configuration.
kubectl config view
# To show the cluster information.
kubectl cluster-info
# To check running nodes.
kubectl get nodes
# To see a list of all the Minikube pods run.
kubectl get pods
# To enter ssh pods
kubectl exec -it <pod_name> -- /bin/sh
# To ssh into the Minikube VM. To exit out of the shell run "exit"
minikube ssh
# To stop running the single node cluster.
minikube stop
# To see the minikube ip
minikube ip
# To check its status.
minikube status
# To delete the single node cluster.
minikube delete
# To see a list of installed Minikube add-ons.
minikube addons list
# To enable and access the Minikube dashboard via terminal.
# Once you exit the terminal, the process will end and the Minikube dashboard will shut down.
minikube dashboard
```
### Usage

> Deployment

```shell
git clone https://github.com/sherchryst/ft_services.git
cd ft_services && sh setup.sh
```

[Back To The Top](#ft_services)
