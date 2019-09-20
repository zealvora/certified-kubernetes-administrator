### Deploying our first Helm chart

##### 1. Link to download Helm

https://github.com/helm/helm/releases 

##### 2. Generic Commands - Installing and Configuring Helm:

```sh
yum -y install nano wget gzip tar
gunzip helm-v2.14.3-linux-amd64.tar.gz
tar -xvf helm-v2.14.3-linux-amd64.tar
cd linux-amd64/
mv helm /usr/bin/
mv tiller /usr/bin/
tiller (run this from second terminal session)
export HELM_HOST=localhost:44134
helm init --client-only
```

##### 3. Link to Helm Charts:

https://github.com/helm/charts/tree/master/stable/

##### 4. Installing Wordpress Helm Chart

```sh
helm install stable/wordpress
```
##### 5. Deleting Helm Chart

```sh
helm delete kind-sabertooth --purge 
```
