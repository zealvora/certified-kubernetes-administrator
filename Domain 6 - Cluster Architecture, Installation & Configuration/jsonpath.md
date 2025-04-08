### Websites and Documentation Referenced

https://jsonpath.com/

https://kubernetes.io/docs/reference/kubectl/jsonpath/

### Create 2 Pods for Testing

```sh
kubectl run pod-1 --image=nginx

kubectl run pod-2 --image=httpd
```

### Fetch the JSON Output
```sh
kubectl get pods -o json

kubectl get pods -o json > outputs.json
```
### Analyze various JSONPath Expressions
```sh
$
$.kind
$.metadata

$.items
$.items[0]
$.items[*]

$.items[*].metadata
$.items[*].metadata.name

$.items[*].spec.containers
$.items[*].spec.containers[*].image]

$.items[*].status.podIP
```

kubectl specific commands
```sh
kubectl get pods -o jsonpath="{$.items[*].metadata.name}"

kubectl get pods -o jsonpath="{$.items[*].status.podIP}"
```
Use the range, end operators to iterate lists.

```sh
kubectl get pods -o jsonpath='{range .items[*]}{.status.podIP}{"\n"}{end}'

kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.podIP}{"\n"}{end}'
```

