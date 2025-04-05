
### Checking the Standard Approach
```sh

helm repo add argo https://argoproj.github.io/argo-helm

helm install my-argo-cd argo/argo-cd --version 7.8.23 --skip-crds --dry-run 

helm install my-argo-cd argo/argo-cd --version 7.8.23 --skip-crds --dry-run | grep CustomResourceDefinition
```

### Skipping the CRDs
```sh
helm install my-argo-cd argo/argo-cd --version 7.8.23 --set crds.install=false --dry-run | grep CustomResourceDefinition

helm template my-argo-cd argo/argo-cd --set crds.install=false --version 7.8.23 > argo-no-crd.yaml
```
