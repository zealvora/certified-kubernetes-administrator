### Pre-Requisite:

Ensure Local Path Provisioner is already setup and configured with appropriate storage class
```sh
kubectl get storageclass
```
### Requirement 

1. There is a deployment named `mariadb` in the `mariadb` namespace. A intern has deleted this deployment by mistake. This deployment used to use a PV named `mariadb-retained-pv` which still exist.

2. Your task is to recreate this deployment with a new PVC that binds to the existing PV called `mariadb-retained-pv`

3. To verify a successful solution, confirm that the MariaDB deployment pod is running and that the '/var/lib/mysql/initial.txt' file exists inside the pod.

### Setup Environement
```sh
wget https://raw.githubusercontent.com/zealvora/certified-kubernetes-administrator/refs/heads/master/Exercises/script-mariadb.sh
```

The mariadb deployment file `mariadb-deployment.yaml` will be created in same folder were you will be running the script. This can be used to recreate the deployment.

<details>
  <summary>Click to view solution</summary>

### Solution

#### Step 1 - Remove the Claim from Existing PVC
```sh
kubectl edit pv mariadb-retained-pv
```
Remove the following lines and save it
```sh
  claimRef:
    apiVersion: v1
    kind: PersistentVolumeClaim
    name: mariadb
    namespace: mariadb
    resourceVersion: "2485466"
    uid: 251c8a23-a843-42ff-a536-4a0fa0e9851e
```
Verify if the claim has been removed.
```sh
kubectl get pv
```
#### Step 2 - Create PVC to Bind to Existing PV
```sh
nano pvc.yaml
```
```sh
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mariadb
  namespace: mariadb
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 250Mi
  storageClassName: local-path
  volumeName: mariadb-retained-pv
```
```sh
kubectl create -f pvc.yaml
```
```sh
kubectl get pvc -n mariadb
```

#### Step 3 - Recreate the Deployment
```sh
kubectl create -f mariadb-deployment.yaml
```

#### Step 4 - Verification
```sh
kubectl get pods -n mariadb

kubectl exec -it <mariadb-pod-name> -n mariadb -- sh
```

Verify if the initial.txt file exists as stated in the requirement
```sh
ls -l /var/lib/mysql
```
</details>


<details>
  <summary>Delete Entire Lab Setup</summary>

```sh
kubectl delete namespace mariadb
kubectl delete pv mariadb-retained-pv
sudo rm -rf /opt/local-path-provisioner/mariadb
rm -f mariadb-deployment.yaml
```
</details>
