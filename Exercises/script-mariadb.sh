#!/bin/bash

set -e

# Configurations
NAMESPACE="mariadb"
PVC_NAME="mariadb"
DEPLOYMENT_NAME="mariadb"
STORAGE_SIZE="250Mi"
STORAGE_CLASS="local-path"
PV_NAME="mariadb-retained-pv"
DEPLOYMENT_FILE="mariadb-deployment.yaml"
LOCAL_PATH_BASE="/opt/local-path-provisioner"
LOCAL_PATH="${LOCAL_PATH_BASE}/${PVC_NAME}"

echo "🔧 Step 1: Creating namespace '$NAMESPACE'..."
kubectl create namespace $NAMESPACE || echo "Namespace already exists"

echo "📁 Creating host path directory for PV..."
sudo mkdir -p $LOCAL_PATH
sudo chmod -R 777 $LOCAL_PATH

echo "📦 Step 2: Creating static PV and PVC with Retain policy..."

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: ${PV_NAME}
spec:
  capacity:
    storage: ${STORAGE_SIZE}
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: ${STORAGE_CLASS}
  local:
    path: ${LOCAL_PATH}
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - $(kubectl get node -o jsonpath="{.items[0].metadata.name}")
  volumeMode: Filesystem
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ${PVC_NAME}
  namespace: ${NAMESPACE}
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: ${STORAGE_SIZE}
  storageClassName: ${STORAGE_CLASS}
  volumeName: ${PV_NAME}
EOF

echo "📝 Writing MariaDB Deployment YAML to: $DEPLOYMENT_FILE"

cat <<EOF > $DEPLOYMENT_FILE
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${DEPLOYMENT_NAME}
  namespace: ${NAMESPACE}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ${DEPLOYMENT_NAME}
  template:
    metadata:
      labels:
        app: ${DEPLOYMENT_NAME}
    spec:
      containers:
      - name: ${DEPLOYMENT_NAME}
        image: mariadb:10.5
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: mypassword
        volumeMounts:
        - name: mariadb-storage
          mountPath: /var/lib/mysql
      volumes:
      - name: mariadb-storage
        persistentVolumeClaim:
          claimName: ${PVC_NAME}
EOF

echo "🚀 Deploying MariaDB from file: $DEPLOYMENT_FILE"
kubectl apply -f $DEPLOYMENT_FILE

echo "⏳ Waiting for MariaDB pod to be ready..."
kubectl wait --namespace ${NAMESPACE} --for=condition=ready pod -l app=${DEPLOYMENT_NAME} --timeout=60s

POD_NAME=$(kubectl get pod -n ${NAMESPACE} -l app=${DEPLOYMENT_NAME} -o jsonpath="{.items[0].metadata.name}")
echo "✅ Pod ${POD_NAME} is ready."

echo "📝 Step 3: Creating 'initial.txt' inside the PV..."
kubectl exec -n ${NAMESPACE} ${POD_NAME} -- bash -c "echo 'This is initial data in PV' > /var/lib/mysql/initial.txt"

echo "📁 Verifying file inside pod:"
kubectl exec -n ${NAMESPACE} ${POD_NAME} -- cat /var/lib/mysql/initial.txt

echo "🧹 Simulating accidental deletion: Deleting Deployment and PVC..."
kubectl delete deployment ${DEPLOYMENT_NAME} -n ${NAMESPACE}
kubectl delete pvc ${PVC_NAME} -n ${NAMESPACE}

echo "📌 Done. PV should be in Released state with data retained."
kubectl get pv ${PV_NAME}