
#### Create a new POD from Nginx Image
```sh
kubectl run nginx --image=nginx
```

#### List  the PODS that are currently running.
```sh
kubectl get pods
```
#### View Logs of a Specific Pod
```sh
kubectl logs nginx
```

#### Describe Pod Information in Detail
```sh
kubectl describe pod nginx
```
#### Connect inside the POD
```sh
kubectl exec -it nginx  -- bash
```

#### Delete the POD
```sh
kubectl delete pod nginx
```

#### View Node Information
```sh
kubectl get nodes

kubectl describe node <add-node-name-here>
```

#### Create 2 Pods as shown in video

```sh
kubectl run nginx-01 --image=nginx
kubectl run nginx-02 --image=nginx
```

#### View Pods with Output of Wide
```sh
kubectl get pods -o wide
```

#### Delete the Pods Created
```sh
kubectl delete pod nginx-01
kubectl delete pod nginx-02
```