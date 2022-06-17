#### Documentation Referred:

https://kubernetes.io/docs/concepts/services-networking/ingress/#name-based-virtual-hosting


#### Step 1: Create PODS associated with Services
```sh
kubectl run service-pod-1 --image=nginx
kubectl run service-pod-2 --image=nginx
```

#### Step 2: Create Service
```sh
kubectl expose pod service-pod-1 --name service1 --port=80 --target-port=80
kubectl expose pod service-pod-2 --name service2 --port=80 --target-port=80
kubectl get services
```

#### Step 3: Verify Service to POD connectivity
```sh
kubectl run frontend-pod --image=ubuntu --command -- sleep 36000
kubectl exec -it frontend-pod -- bash
apt-get update && apt-get -y install curl nano
curl <SERVER-1-IP>
curl <SERVER-1-IP>
```

#### Step 4: Create Ingress Resource
```sh
nano ingress.yaml
```
```sh
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: name-virtual-host-ingress
spec:
  ingressClassName: nginx
  rules:
  - host: website01.example.internal
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: service1
            port:
              number: 80
  - host: website02.example.internal
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: service2
            port:
              number: 80
```
```sh
kubectl apply -f ingress.yaml
kubectl get ingress
kubectl describe ingress name-virtual-host-ingress created
```
