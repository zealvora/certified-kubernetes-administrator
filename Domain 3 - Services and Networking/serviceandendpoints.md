### service.yaml
```sh
apiVersion: v1
kind: Service
metadata:
   name: kplabs-service
spec:
   ports:
   - port: 8080
     targetPort: 80
```

### endpoint.yaml 
```sh
apiVersion: v1
kind: Endpoints
metadata:
  name: kplabs-service
subsets:
  - addresses:
      - ip: 10.244.0.23
    ports:
      - port: 80
```
