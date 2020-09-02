#### Add following flag in kube-apiserver

```sh
--kubelet-preferred-address-types InternalIP 
```
#### Restar tkube-apiserver
```sh
systemctl restart kube-apiserver
```
### Do an exec into any of the pods for verification.
