#### Documentation Referred:

https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/

#### Step 0: Remove Hosts entry

Remove /etc/hosts entry associated with kplabs-cka-worker
```sh
nano /etc/hosts
```
#### Step 1: Try connecting to Nginx pod:
```sh
kubectl exec -it nginx -- ls
```
#### Step 2: Describe Worker Node:
```sh
kubectl describe node kplabs-cka-worker
```

#### Step 3: Modify the Configuration file for API Service
```sh
nano /etc/systemd/system/kube-apiserver.service
```

##### Add the following flag:
```sh
--kubelet-preferred-address-types InternalIP
```
```sh
systemctl daemon-reload
systemctl restart kube-apiserver
```

#### Step 4: Verify Connectivity
```sh
kubectl exec -it  nginx -- ls
```
