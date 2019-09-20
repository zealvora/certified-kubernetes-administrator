
##### 1. See Logs of a Specific Unit (Services)
```sh
journalctl -u kube-apiserver
```
##### 2. Tail Logs
```sh
journalctl -f -u kube-apiserver
```
##### 3. Show logs since a specific time.
```sh
journalctl --since "2019-09-17 14:10:10"
```
```sh
journalctl --since "2019-09-17 14:10:10" --until "2019-09-18 05:10:10"
```
