### Documentation Referred:

https://kubernetes.io/docs/reference/access-authn-authz/authentication/

### Fetching the Default Token:
```sh
kubectl get secret
kubectl describe secret [YOUR-SECRET-NAME]
```
### Sending Request to K8s using Bearer Token:
```sh
curl -k https://YOUR-CLUSTER-DNS-HERE/api/v1 --header "Authorization: Bearer YOUR-TOKEN-HERE"
```
