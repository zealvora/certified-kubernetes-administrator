
#### Step 1. Creating Deployment via CLI
```sh
kubectl create deployment DEPLOYMENT-NAME --image=[IMAGE-NAME]
```

#### Step 2. Generating Deployment Manifest via CLI
```sh
kubectl create deployment DEPLOYMENT-NAME --image=[IMAGE-NAME] --dry-run=client -o yaml
```
```sh
kubectl create deployment --help
```
