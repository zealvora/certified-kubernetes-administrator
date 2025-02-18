### Documentation / Websites Referenced:

https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.32/

#### Check Resources as part of specific API Group
```sh
kubectl api-resources --api-group="apps"
kubectl api-resources --api-group=""
```
#### Create Role
```sh
kubectl create role --help

kubectl create role pod-reader --verb=list --resource=pods 

kubectl get roles

kubectl describe role pod-reader
```
#### Test the Permissions
```sh
kubectl cluster-info
```

Replace the `K8S-DETAILS-HERE` with the output you get in previous command
```sh
curl -k https://K8S-DETAILS-HERE/api/v1/namespaces/default/pods --header "Authorization: Bearer $TOKEN"
```

#### Create RoleBinding
```sh
kubectl create rolebinding --help

kubectl create rolebinding test-rolebinding --role=pod-reader --user=system:serviceaccount:default:test-sa

kubectl get rolebinding

kubectl describe rolebinding test-rolebinding
```
#### Test the Permissions
```sh
kubectl run test-pod --image=nginx
```
Replace the URL in below command to your K8s URL. If using macOS or Linux, use `$TOKEN` instead of `%TOKEN%`
```sh
curl -k https://38140ecd-e8d7-4fff-be52-24629c40cdac.k8s.ondigitalocean.com/api/v1/namespaces/default/pods --header "Authorization: Bearer %TOKEN%"
```
#### Generate Manifest Files for Role and Role Binding
```sh
kubectl create role test-role --verb=list --resource=pods --dry-run=client -o yaml

kubectl create rolebinding test-rolebinding --role=pod-reader --user=system:serviceaccount:default:test-sa --dry-run=client -o yaml
```
#### Delete Role and RoleBinding
```sh
kubectl delete role pod-reader 

kubectl delete rolebinding test-rolebinding
```