
  ### Note:
  Step 1 to 3 will be on Worker node
  Step 4 will be on Master node.

  #### Step 1: Download CNI Plugins:
  ```sh
  cd /tmp

  wget https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-amd64-v1.1.1.tgz

  ```
  #### Step 2: Configure Base Directories:
  ```sh
  mkdir -p \
    /etc/cni/net.d \
    /opt/cni/bin \
    /var/run/kubernetes
  ```
  #### Step 3: Move CNI Tar File And Extract it.
  ```sh
  mv cni-plugins-linux-amd64-v1.1.1.tgz /opt/cni/bin
  cd /opt/cni/bin
  tar -xzvf cni-plugins-linux-amd64-v1.1.1.tgz
  ```
  #### Step 4: Configuring Weave (Run this step on Master Node)

  ```sh
  kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')&env.IPALLOC_RANGE=10.200.0.0/16"
  ```

  #### Step 5: Verification
  ##### Master Node
  ```sh
  kubectl get nodes
  kubectl run nginx --image=nginx
  ```
  ##### Worker Node
  ```sh
  apt install net-tools
  ifconfig
  route -n
  ```

#### Step 6: Testing POD Exec (Master Node)
```sh
kubectl exec nginx -- ls
```
```sh
nano /etc/hosts
```
128.199.30.177 kplabs-cka-worker
