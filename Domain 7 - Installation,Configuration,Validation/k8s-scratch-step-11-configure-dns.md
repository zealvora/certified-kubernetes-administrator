```sh
kubectl create -f https://storage.googleapis.com/kubernetes-the-hard-way/kube-dns.yaml
```
```sh
kubectl run busybox --image=busybox:1.28 --command -- sleep 3600
```
```sh
nslookup kubernetes
```
