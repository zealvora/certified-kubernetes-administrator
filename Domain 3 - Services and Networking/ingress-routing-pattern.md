
### Base Command Used to Create Manifest For Path Based Routing
```sh
kubectl create ingress path-based-ingress --rule=*/=example-service:80 --dry-run-client -o yaml
```
### Final Manifest File for Path Based Ingress

path-based-ingress.yaml

```sh
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  creationTimestamp: null
  name: path-based-ingress
spec:
  rules:
   - http:
      paths:
      - backend:
          service:
            name: app-1-service
            port:
              number: 80
        path: /app-1
        pathType: Exact
      - backend:
          service:
            name: app-2-service
            port:
              number: 80
        path: /app-2
        pathType: Exact
```
```sh
kubectl create -f path-based-ingress.yaml

kubectl describe ingress path-based-ingress
```

### Base Command Used to Create Manifest For Named+Path Based Routing
```sh
kubectl create ingress named-path --rule=example.internal/=app-1:80 --dry-run-client -o yaml
```
### Final Manifest File for Named+Path Based Ingress

```sh
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  creationTimestamp: null
  name: named-path
spec:
  rules:
  - host: example.internal
    http:
      paths:
      - backend:
          service:
            name: app-1-service
            port:
              number: 80
        path: /app-1
        pathType: Exact
      - backend:
          service:
            name: app-2-service
            port:
              number: 80
        path: /app-2
        pathType: Exact
```
```sh
kubectl create -f named-path.yaml

kubectl describe ingress named-path
```