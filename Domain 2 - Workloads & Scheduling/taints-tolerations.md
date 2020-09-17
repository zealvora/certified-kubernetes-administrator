
kubectl taint nodes kubeadm-worker-01 key=value:NoSchedule

kubectl describe node kubeadm-worker-01

kubectl run nginx --image=nginx
