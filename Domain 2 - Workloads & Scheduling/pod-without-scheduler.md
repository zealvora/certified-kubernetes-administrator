#### Generic Commands:
```sh
systemctl status kubelet
cd /etc/systemd/system/kubelet.service.d
```

#### kplabs-pod.yaml
```sh
apiVersion: v1
kind: Pod
metadata:
  name: kplabs-pod
spec:
  containers:
  - name: kplabs-container
    image: nginx
```    
