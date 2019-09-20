#### pod-logging.yaml 
```sh
kind: Pod
apiVersion: v1
metadata:
  name: pod01
spec:
  containers:
    - name: ping-container
      image: busybox
      command: ["ping"]
      args: ["google.com"]
```

#### multi-container-pod-logging.yaml

```sh
kind: Pod
apiVersion: v1
metadata:
  name: pod02
spec:
  containers:
    - name: ping-container-domain
      image: busybox
      command: ["ping"]
      args: ["google.com"]
    - name: ping-container-ip
      image: busybox
      command: ["ping"]
      args: ["8.8.8.8"]
```
