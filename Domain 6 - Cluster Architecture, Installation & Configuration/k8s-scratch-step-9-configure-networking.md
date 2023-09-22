
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
  #### Step 4: Configuring Weave (Run this step on Master Node) - IMPORTANT
  
  The cloud.weave.works command that was used in the video will no longer work as the website is now down. Instead you can use the following command to setup networking.
  

  ```sh
kubectl apply -f https://raw.githubusercontent.com/zealvora/certified-kubernetes-administrator/master/Domain%206%20-%20Cluster%20Architecture%2C%20Installation%20%26%20Configuration/weave-daemonset-k8s.yaml
  ```

  #### Note

  In-case if the worker node continues to be in NotReady status even after few minutes, you can restart the kubelet in the worker node
 ```sh
  systemctl restart kubelet
 ```

  #### Step 5: Verification
  ##### Master Node
  ```sh
  kubectl get nodes
  kubectl run nginx --image=nginx
  ```
  #### Note

  In-case if you have restarted kubelet and you run the kubectl run nginx to create a POD from master node, it can happen that Status will show Error message. In such-case, just wait for 2-3 minutes and the error would automatically go away and will change to Running.

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
```sh
142.93.218.230 kplabs-cka-worker
```
```sh
kubectl exec nginx -- ls
```
