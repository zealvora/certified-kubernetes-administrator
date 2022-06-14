
#### Step 1: Create Sample POD with Label
```sh
kubectl run nodeport-pod --labels="type=publicpod" --image=nginx
kubectl get pods --show-labels
```
#### Step 2: Create NodePort service
```sh
nano nodeport.yaml
```
```sh
apiVersion: v1
kind: Service
metadata:
   name: kplabs-nodeport
spec:
   selector:
     type: publicpod
   type: NodePort
   ports:
   - port: 80
     targetPort: 80
```
```sh
kubectl apply -f nodeport.yaml
```
#### Step 3: Verify NodePort
```sh
kubectl get service
```
#### Step 4: Fetch the Worker Node Public IP
```sh
kubectl get nodes -o wide
```

Copy the Public IP of Worker Node and Paste it in browser along with NodePort

#### Step 5: Delete the Resources
```sh
kubectl delete pod nodeport-pod
kubectl delete -f nodeport.yaml
```
