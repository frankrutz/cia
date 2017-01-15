# Azure Cloud User Group Switzerland
# Containers In Azure
# Complete Infrastructure Automation

18.Jan 2017 @ Microsoft Schweiz, Wallisellen

https://www.meetup.com/Azure-Cloud-User-Group-Switzerland/events/235434796/

## Azure Container Service / Kubernetes / Jobs

Using Ubuntu Bash in Windows 10, we create a Kubernetes Cluster with Azure Container Service. Our pods have two containers each, an appserver and a dbserver. 

Highlights will be:  
- Bash on Windows
- Azure Container Service: How to create a Kubernetes cluster 
- Microsoft SQL DB in a Linux Container : superfast creation 
- Azure Container Registry 
- Kubernetes Pods 
- Kubernetes Secrets 
- Kubernetees Jobs 
- How to delete the cluster


## Bash on Windows 10

To prepare for running kubernetes from a Windows 10 bash, we install 
- Bash
- Azure CLI
- Kubectl
- Git

Install instructions for bash on Windows 10:
http://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/

Install Azure CLI on Ubuntu:
https://github.com/Azure/azure-cli

Install kubectl on Ubuntu:
http://kubernetes.io/docs/user-guide/prereqs/

Installing git:
apt-get install git

Finally, we generate ssh keys. No passphrase.

ssh-keygen -t rsa

If you want to clone this repository to your local computer, use

git clone https://github.com/potf0815/cia

## Azure Container Service: How to create a Kubernetes cluster 
You may want to install the cluster in its own resource group.
This makes it easy to delete in the end.

az login

az group create -l westeurope -n resgrpexampel

az acs create --orchestrator-type=kubernetes --resource-group=resgrpexampel --dns-prefix=dnsexample --name=k8sexample

creating the cluster will typically take about five minutes.

az acs kubernetes get-credentials  --resource-group=resgrpexampel --dns-prefix=dnsexample --name=k8sexample

kubectl cluster-info


## Microsoft SQL DB in a Linux Container 

See 

https://hub.docker.com/r/microsoft/mssql-server-linux/

To start a pod with just the database:

kubectl create -f mssql.yaml

## Azure Container Registry 

Very similar to the docker registry experience.

To connect to the Azure Container Registry from Kubernetes,

create a kubernetes secret.

See createAZCRsecret.ksh

## Example Two-Container Pod appsserver and dbserver started as a job.

appserver: Application Server, CentOs with sqlcmd installed.

dbserver: The MSSQL Server running native on Ubuntu.

kubectl create -f secretpassword.yaml

kubectl create -f jobtest001.yaml

kubectl create -f jobtest002.yaml

kubectl create -f jobtest003.yaml


## How to delete the cluster

In case you set up everything in its own resource group, just delete the resource group.
 
## Extra material
 
## Creating the AppServer Container

We create a Centos Container which can run sqlcmd.

https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools

Using the included dockerfile, we build an intermediate container

docker build -t tempcontainer .

And run it interactively with 

docker run -it tempcontainer bash

Once we are inside the container, we can install sqlcmd: 
 
yum -y update

yum install mssql-tools unixODBC-utf16-devel

ln -sfn /opt/mssql-tools/bin/sqlcmd-13.0.1.0 /usr/bin/sqlcmd

ln -sfn /opt/mssql-tools/bin/bcp-13.0.1.0 /usr/bin/bcp

Answer YES to the license terms if you want to.

Exit the container.

Using the CONTAINER ID of the stopped container, create a new container named appservtest

The CONTAINER ID will be different in your case.

docker commit 3e8736b7a769 appservtest


## Pushing the appservtest image to Azure Container Registry

You find the credentials on the Access Key Page of your Azure Container Registry ( yellow key symbol ).

docker login regwalli001-on.azurecr.io -u username -p password

docker tag appservtest regwalli001-on.azurecr.io/appservtest

docker push regwalli001-on.azurecr.io/appservtest
 
 
 
