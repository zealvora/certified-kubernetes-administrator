
### Create Test Pod
```sh
kubectl run test-pod --image=nginx
```
### Approach 1 - kubectl edit
```sh
kubectl edit pod test-pod
```
Modify the label to `dev-pod` from `test-pod`

### Approach 2 - kubectl patch
```sh
kubectl get pod test-pod -o json
```
For Linux:
```sh
kubectl patch pod test-pod -p '{"metadata":{"labels":{"run":"dev-pod"}}}'
```
For Windows
```sh
kubectl patch pod test-pod -p "{\"metadata\":{\"labels\":{\"run\":\"dev-pod\"}}}"
```