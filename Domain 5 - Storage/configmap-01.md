
### Creating ConfigMap From Literal

```sh
kubectl create configmap --help

kubectl create configmap first-configmap --from-literal=key1=value1 --from-literal=key2=value2

kubectl describe configmap first-configmap

kubectl get configmap first-configmap -o yaml
```

### Creating ConfigMap From File

large-file.txt
```sh
key1=value1
key2=value2
key3=value3
```

```sh
kubectl create configmap second-configmap --from-file=large-file.txt

kubectl get configmap second-configmap -o yaml
```
### Creating ConfigMap From Directory

Contents of Big Folder

first-file.txt
```sh
key1=value1
key2=value2
key3=value3
```
second-file.txt
```sh
key4=value4
key5=value5
key6=value6
```
```sh
kubectl create configmap second-configmap --from-file=big-folder

kubectl get configmap third-configmap -o yaml
```

### ConfigMap Manifest File (configmap.yaml)

```sh
apiVersion: v1
kind: ConfigMap
metadata:
   name: manifest-configmap
data:
   key1: "value1"
   key2: "value2"

   big-data: |
      This is Line 1
      This is Line 2
      This is Line 3
```
```sh
kubectl create -f configmap.yaml

kubectl get configmap manifest-configmap -o yaml
```

### Delete All the Resource After Practical

```sh

kubectl delete -f configmap.yaml

kubectl delete configmap first-configmap
kubectl delete configmap second-configmap
kubectl delete configmap third-configmap
```