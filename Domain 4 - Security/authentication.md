### Documentation and Websites Referred:

https://kubernetes.io/docs/reference/access-authn-authz/authentication/

https://token.dev/


#### Step 1: Create a new Service Account:
```sh
kubectl create serviceaccount external
```

#### Step 2: Create a new POD with External Service Account
```sh
kubectl run external-pod --image=nginx --dry-run=client -o yaml
```
Add following contents under .spec
```sh
serviceAccountName: external
```
Final File will look like this:

```sh
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: external-pod
  name: external-pod
spec:
  serviceAccountName: external
  containers:
  - image: nginx
    name: external-pod
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```
```sh
kubectl apply -f pod-sa.yaml
```
#### Step 3: Verification
```sh
kubectl get pods
kubectl get pod external -o yaml
```
#### Step 4: Fetch the Token of a POD

```sh
kubectl exec -it external-pod -- bash
cat /var/run/secrets/kubernetes.io/serviceaccount/token
```

#### Step 5: Make a Request to Kubernetes using Token
```sh
curl -k <K8S-SERVER-URL>
curl -k <K8S-SERVER-URL>/api/v1 --header "Authorization: Bearer <TOKEN-HERE>"
```
