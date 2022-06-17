### Artifact Hub Page:

https://artifacthub.io/


## Deploying Jenkins Helm Chart

https://artifacthub.io/packages/helm/jenkinsci/jenkins

##### Step 1. Configure and Install Jenkins Helm Chart

```sh
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm install my-jenkins jenkins/jenkins
```
##### Step 2. Verify the List of Releases

```sh
helm list
```
##### Step 3. Uninstall Jenkins Helm Chart

```sh
helm uninstall my-jenkins
```

## Deploying WordPress Helm Chart (Run this in Big Node)

https://artifacthub.io/packages/helm/bitnami/wordpress

##### Step 1. Configure and Install Wordpress Helm Chart

```sh
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-release bitnami/wordpress
```

##### Step 2. Uninstall Wordpress Helm Chart

```sh
helm uninstall my-release
```
