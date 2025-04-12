### Setup Environement
```sh
wget https://raw.githubusercontent.com/zealvora/certified-kubernetes-administrator/refs/heads/master/Domain%208%20-%20Troubleshooting/script-cm-deploy.sh

chmod +x script-cm-deploy.sh

./script-cm-deploy.sh
```


### Requirement:

Your task is to modify the setup so that the Nginx server in the `secure-web` deployment ONLY accepts TLS 1.3 connections. 
 
1. Modify the ConfigMap associated with deployment to only allow `TLS v1.3` using any way possible.

2. You can test the setup using following command to verify if `TLSv1.2` and `TLS v1.3` are accepted.


Terminal Tab-1
```sh
kubectl port-forward service/secure-web-svc 8443:443
```
Terminal Tab-2
```sh
openssl s_client -connect secure-web.local:8443 -tls1_2

openssl s_client -connect secure-web.local:8443 -tls1_3
```
<details>
  <summary>Click to view solution</summary>
### Solution
```sh
kubectl get configmap

kubectl describe configmap nginx-config-v1

kubectl get configmap nginx-config-v1 -o yaml > configmap-v2.yaml
```
```sh
nano configmap-v2.yaml
```
```sh
ssl_protocols TLSv1.3;
name: nginx-config-v2
```
```sh
kubectl create configmap nginx-config-v2

kubectl edit deployment secure-web
```
```sh
volumes:
      - configMap:
          name: nginx-config-v2
```
```sh
kubectl get pods
```

### Test TLS 1.2 and TLS 1.3 Connection (After Solution)
```sh
kubectl port-forward service/secure-web-svc 8443:443

openssl s_client -connect secure-web.local:8443 -tls1_2

openssl s_client -connect secure-web.local:8443 -tls1_3
```
</details>

<details>
  <summary>Delete Resources created in this Lab</summary>
### Delete Resources
```sh
kubectl delete deployment secure-web

kubectl delete configmap nginx-config-v1

kubectl delete service secure-web-svc

kubectl delete secret tls-secret

rm tls.crt  tls.key configmap-v2.yaml
```
</details>