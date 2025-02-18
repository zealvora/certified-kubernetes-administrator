
#### Create ClusterRole
```sh
kubectl create clusterrole pod-reader --verb=get,list,watch --resource=pods

kubectl describe clusterrole pod-reader
```
#### Create ClusterRoleBinding
```sh
kubectl create clusterrolebinding test-clusterrole --clusterrole=pod-reader --user=system:serviceaccount:default:test-sa

kubectl describe clusterrolebinding test-clusterrole
```
#### Test the Setup

Replace the URL in below command to your K8s URL. If using macOS or Linux, use `$TOKEN` instead of `%TOKEN%`

```sh
curl -k https://38140ecd-e8d7-4fff-be52-24629c40cdac.k8s.ondigitalocean.com/api/v1/namespaces/default/pods --header "Authorization: Bearer %TOKEN%"
```

```sh
curl -k https://38140ecd-e8d7-4fff-be52-24629c40cdac.k8s.ondigitalocean.com/api/v1/namespaces/kube-system/pods --header "Authorization: Bearer %TOKEN%"
```

