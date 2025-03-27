### Documentation Referenced:

https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/

### Define a CRD
```sh
nano crd.yaml
```
```sh
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: databases.kplabs.internal
spec:
  group: kplabs.internal
  names:
    kind: Database
    listKind: DatabaseList
    plural: databases
    singular: database
  scope: Namespaced
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                name:
                  type: string
                replicas:
                  type: integer
```
```sh
kubectl create -f crd.yaml

kubectl get crd
```
### Create Custom Resource
```sh
nano db.yaml
```
```sh
apiVersion: kplabs.internal/v1
kind: Database
metadata:
  name: my-database
spec:
  name: test-db
  replicas: 3
```

```sh
kubectl create -f db.yaml
kubectl get database
```