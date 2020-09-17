
#### Step 1: Verify the status of DNS
```sh
kubectl cluster-info
```
#### Step 2: Create a BusyBox POD to test DNS
```sh
kubectl run busybox --image=busybox:1.28 --command -- sleep 3600
```
```sh
kubectl exec -it busybox -- sh
nslookup google.com
ping 8.8.8.8
```
#### Step 3: Install CoreDNS:
```sh
wget https://raw.githubusercontent.com/zealvora/certified-kubernetes-administrator/master/Domain%207%20-%20Installation%2CConfiguration%2CValidation/coredns.yaml
```
```sh
kubectl apply -f coredns.yaml
```

#### Step 4: Verify if DNS Resolution Works:

```sh
kubectl get pods -n kube-system
kubectl exec -it busybox -- sh
nslookup google.com
nslookup kubernetes
```
