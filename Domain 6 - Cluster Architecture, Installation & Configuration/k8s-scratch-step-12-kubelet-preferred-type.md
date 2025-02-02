#### Documentation Referred:

https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/

#### Step 1: Remove Hosts entry

Remove /etc/hosts entry associated with `worker`
```sh
nano /etc/hosts
```
#### Step 2: Try connecting to Nginx pod:
```sh
kubectl exec -it nginx -- ls
```
#### Step 3: Describe Worker Node:
```sh
kubectl describe node worker
```

#### Step 4: Modify the Configuration file for API Service
```sh
nano /etc/systemd/system/kube-apiserver.service
```

#### Step 5: Add the following flag:
```sh
--kubelet-preferred-address-types InternalIP
```
```sh
systemctl daemon-reload

systemctl restart kube-apiserver
```
The restart of kube-apiserver can take 2-3 minutes.

### Step 6: Verify Connectivity
```sh
kubectl exec -it  nginx -- ls
```
