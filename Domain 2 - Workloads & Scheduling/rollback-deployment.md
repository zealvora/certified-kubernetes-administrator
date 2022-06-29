
#### Rollback to previous Revision
```sh
kubectl rollout undo deployment/kplabs-deployment --to-revision=1

kubectl get rs

kubectl describe deployment kplabs-deployment

kubectl rollout history deployment/kplabs-deployment
```