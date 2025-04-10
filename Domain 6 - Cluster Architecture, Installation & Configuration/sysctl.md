
### Step 1 - Understanding the Structure
```sh
ls -l /proc/sys

ls -l /proc/sys/net

ls -l /proc/sys/net/ipv4

cat /proc/sys/net/ipv4/ip_forward
```
### Step 2 - Modifying the Parameters
```sh
sysctl vm.swappiness

cat /proc/sys/vm/swappiness

echo 70 > /proc/sys/vm/swappiness

sysctl vm.swappiness

sysctl vm.swappiness=80

sysctl vm.swappiness
```
Restart the system using `reboot` to verify if change persists

```sh
sysctl vm.swappiness
```
### Step 3 - Making Changes Permanant
```sh
cd /etc/sysctl.d

nano 99-custom.conf 
```
Add following line in the file
```sh
vm.swappiness=70
```
```sh
sysctl --system
```

Restart the system using `reboot` to verify if change persists

```sh
sysctl vm.swappiness
```