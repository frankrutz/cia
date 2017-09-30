# Azure Cloud User Group Switzerland
# Containers In Azure

18.Jan 2017 @ Microsoft Schweiz, Wallisellen

Updated 30.Sep 2017 for usage with Azure Cloud Shell

https://www.meetup.com/Azure-Cloud-User-Group-Switzerland/events/235434796/

## Azure Container Service / Kubernetes / Jobs

Using Azure Cloud Shell (cs), we create a Kubernetes Cluster with Azure Container Service. Our pods have two containers each, an appserver and a dbserver. 

Highlights will be:  
- Bash via Azure Cloud Shell
- Azure Container Service: How to create a Kubernetes cluster 
- Microsoft SQL DB in a Linux Container : superfast creation 
- Azure Container Registry 
- Kubernetes Pods 
- Kubernetes Secrets 
- Kubernetees Jobs 
- How to delete the cluster


To prepare for running kubernetes from Azure Cloud Shell (cs), just go the the Azure portal and launch cloud shell.

If you want to clone this repository, in cs:

git clone https://github.com/potf0815/cia

## Azure Container Service: How to create a Kubernetes cluster 

The commands can be found in the file lab_steps.txt

You may want to install the cluster in its own resource group.

This makes it easy to delete in the end.

Exchange the names below



az group create -l westeurope -n resgrpexample

If you have ssh-keys, leave generate-ssh-keys out

az acs create --orchestrator-type=kubernetes --resource-group=resgrpexample --dns-prefix=dnsexample --name=k8sexample --generate-ssh-keys

creating the cluster will typically take about five minutes.

az acs kubernetes get-credentials  --resource-group=resgrpexample --name=k8sexample

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

We create a Centos Container which can run sqlcmd and bcp

https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools

docker build -t appservtest .

## Pushing the appservtest image to Azure Container Registry

You find the credentials on the Access Key Page of your Azure Container Registry ( yellow key symbol ).

docker login regwalli001-on.azurecr.io -u username -p password

docker tag appservtest regwalli001-on.azurecr.io/appservtest

docker push regwalli001-on.azurecr.io/appservtest
 
 
 
 
 
 
 
 
 
 
 
 
## Old version :: running from windows bash :: manual generation of ssh-keys

If you don't want to use cloud shell, you may want to setup your bash-environment as follows:
Install instructions for bash on Windows 10:
http://www.howtogeek.com/249966/how-to-install-and-use-the-linux-bash-shell-on-windows-10/

Install Azure CLI on Ubuntu:
https://github.com/Azure/azure-cli

Install kubectl on Ubuntu:
http://kubernetes.io/docs/user-guide/prereqs/

Installing git:
apt-get install git
 
To generate ssh-keys, no passphrase:
ssh-keygen -t rsa
