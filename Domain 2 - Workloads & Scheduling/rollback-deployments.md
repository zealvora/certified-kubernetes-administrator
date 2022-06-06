#### View previous rollout revisions
```sh
kubectl rollout history deployment/kplabs-deployment
```
#### Rolling Back to previous version of deployment
```sh
kubectl rollout undo deployment/kplabs-deployment --to-revision=1
```
