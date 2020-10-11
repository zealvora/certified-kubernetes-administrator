##### Generating Secret Based on Generic - Literal Value
```sh
kubectl create secret generic  firstsecret --from-literal=dbpassword=mypassword123
```
#####Generating Secret Based on Generic - File
```sh
kubectl create secret generic  secondsecret --from-file=./credentials.txt
```
##### To View Secret from CLI
```sh
kubectl get secret firstsecret -o yaml
```

##### secret-data.yaml

```sh
apiVersion: v1
kind: Secret
metadata:
  name: thirdsecret
type: Opaque
data:
  username: ZGJhZG1pbg==
  password: bXlwYXNzd29yZDEyMw==
```

##### secret-stringdata.yaml

```sh
apiVersion: v1
kind: Secret
metadata:
  name: stringdata
type: Opaque
stringData:
 config.yaml: |-
   username: dbadmin
   password: mypassword

```
