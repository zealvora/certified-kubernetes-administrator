#### Documentation Referred:

https://kubernetes.io/docs/reference/access-authn-authz/authorization/

##### Step 1: Delete Role and Role Binding
```sh
kubectl delete -f role.yaml
```
##### Step 2: Create a Cluster Role
```sh
nano cluster-role.yaml
```
```sh
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["list"]
```
```sh
kubectl apply -f cluster-role.yaml
```
```sh
kubectl get clusterrole
kubectl describe clusterrole pod-reader
```

#### Step 3: Create a Cluster Role Binding
```sh
nano cluster-role-binding.yaml
```
```sh
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: list-pods-global
subjects:
- kind: User
  name: system:serviceaccount:default:external
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```
```sh
kubectl cluster-role-binding.yaml
```
```sh
kubectl get clusterrolebinding
kubectl describe clusterrolebinding list-pods-global
```
##### Step 4: Verify Permissions
```sh
curl -k <K8S-SERVER-URL>/api/v1/namespaces/default/pods --header "Authorization: Bearer <TOKEN-HERE>"
```
##### Step 5: Create a new Namespace
```sh
kubectl create namespace external
```
```sh
curl -k <K8S-SERVER-URL>/api/v1/namespaces/external/pods --header "Authorization: Bearer <TOKEN-HERE>"
```

##### Step 6: Delete Cluster Role Binding
```sh
kubectl delete -f clusterrolebinding list-pods-global
```
Verify if you receive forbidden error.
```sh
curl -k <K8S-SERVER-URL>/api/v1/namespaces/external/pods --header "Authorization: Bearer <TOKEN-HERE>"
```

##### Step 7: Create Role Binding with ClusterRole
```sh
nano clusterrole-to-rolebinding.yaml
```
```sh
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: User
  name: system:serviceaccount:default:external
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```
```sh
kubectl apply -f clusterrole-to-rolebinding.yaml
```
#### Step 8: Verification
```sh
curl -k <K8S-SERVER-URL>/api/v1/namespaces/external/pods --header "Authorization: Bearer <TOKEN-HERE>"
```
```sh
curl -k <K8S-SERVER-URL>/api/v1/namespaces/default/pods --header "Authorization: Bearer <TOKEN-HERE>"
```
