#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
SECRET_NAME="tls-secret"
CONFIGMAP_V1_NAME="nginx-config-v1"
DEPLOYMENT_NAME="secure-web"
SERVICE_NAME="secure-web-svc"
TLS_KEY_FILE="tls.key"
TLS_CERT_FILE="tls.crt"
SERVER_CN="secure-web.local" # Common Name for the certificate & Nginx server_name

# --- Step 1: Generate TLS Certificate and Key ---
echo "--- Generating self-signed TLS certificate (${TLS_CERT_FILE}, ${TLS_KEY_FILE}) ---"
if [ -f "$TLS_KEY_FILE" ]; then
    echo "Removing existing ${TLS_KEY_FILE}"
    rm "$TLS_KEY_FILE"
fi
if [ -f "$TLS_CERT_FILE" ]; then
    echo "Removing existing ${TLS_CERT_FILE}"
    rm "$TLS_CERT_FILE"
fi

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout "$TLS_KEY_FILE" -out "$TLS_CERT_FILE" \
  -subj "/CN=${SERVER_CN}"
echo "Certificate and Key generated."
echo ""

# --- Step 2: Delete Existing Kubernetes Resources (for idempotency) ---
echo "--- Deleting existing Kubernetes resources (if any) ---"
kubectl delete deployment "$DEPLOYMENT_NAME" --ignore-not-found=true
kubectl delete service "$SERVICE_NAME" --ignore-not-found=true
kubectl delete configmap "$CONFIGMAP_V1_NAME" --ignore-not-found=true # Delete potential v2 as well for clean slate
kubectl delete configmap "nginx-config-v2" --ignore-not-found=true
kubectl delete secret "$SECRET_NAME" --ignore-not-found=true
echo ""

# --- Step 3: Create Kubernetes Secret ---
echo "--- Creating Kubernetes Secret '${SECRET_NAME}' ---"
kubectl create secret tls "$SECRET_NAME" --cert="$TLS_CERT_FILE" --key="$TLS_KEY_FILE"
echo "Secret created."
echo ""

# --- Step 4: Create Initial Immutable ConfigMap (TLS 1.2 & 1.3) ---
echo "--- Creating immutable ConfigMap '${CONFIGMAP_V1_NAME}' (TLS 1.2 & 1.3) ---"
kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: ${CONFIGMAP_V1_NAME}
immutable: true # This ConfigMap cannot be changed after creation
data:
  nginx.conf: |
    events {}
    http {
      server {
        listen 443 ssl;
        server_name ${SERVER_CN}; # Matches CN in cert

        ssl_certificate /etc/nginx/ssl/tls.crt;
        ssl_certificate_key /etc/nginx/ssl/tls.key;

        # Initial configuration: Supports TLS 1.2 and TLS 1.3
        ssl_protocols TLSv1.2 TLSv1.3;

        ssl_ciphers 'TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384';
        ssl_prefer_server_ciphers off;

        location / {
          root /usr/share/nginx/html;
          index index.html index.htm;
          # Simple content for testing
          try_files \$uri \$uri/ =404;
          add_header Content-Type text/plain;
          return 200 "Hello from Nginx (TLS 1.2/1.3 initially)!\\n";
        }
      }
    }
EOF
echo "ConfigMap ${CONFIGMAP_V1_NAME} created."
echo ""

# --- Step 5: Create Deployment ---
echo "--- Creating Deployment '${DEPLOYMENT_NAME}' using '${CONFIGMAP_V1_NAME}' ---"
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${DEPLOYMENT_NAME}
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
      - name: nginx
        image: nginx:stable
        ports:
        - containerPort: 443
          name: https
        volumeMounts:
        - name: nginx-config-volume
          mountPath: /etc/nginx/nginx.conf # Mount the config file
          subPath: nginx.conf             # Use the nginx.conf key from the ConfigMap
        - name: tls-certs
          mountPath: /etc/nginx/ssl      # Mount TLS certs
          readOnly: true
      volumes:
      - name: nginx-config-volume
        configMap:
          name: ${CONFIGMAP_V1_NAME} # Use the initial ConfigMap
      - name: tls-certs
        secret:
          secretName: ${SECRET_NAME} # Use the TLS secret
EOF
echo "Deployment ${DEPLOYMENT_NAME} created."
echo ""

# --- Step 6: Create Service ---
echo "--- Creating Service '${SERVICE_NAME}' ---"
kubectl apply -f - <<EOF
apiVersion: v1
kind: Service
metadata:
  name: ${SERVICE_NAME}
spec:
  selector:
    app: ${DEPLOYMENT_NAME} # Selects pods labeled 'app: secure-web'
  ports:
    - protocol: TCP
      port: 443       # Port exposed by the service
      targetPort: https # Port on the pod (references the containerPort name 'https')
  type: ClusterIP # Use ClusterIP for internal access (we'll use port-forward)
EOF
echo "Service ${SERVICE_NAME} created."
echo ""

# --- Step 7: Wait for Deployment Rollout ---
echo "--- Waiting for Deployment '${DEPLOYMENT_NAME}' to be ready ---"
kubectl rollout status deployment/"${DEPLOYMENT_NAME}" --timeout=120s
echo "Deployment is ready."
echo ""

echo "127.0.0.1 secure-web.local" >> /etc/hosts