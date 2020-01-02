### Question 1: Creating Single Container Pods 

<details><summary>Expand The Question </summary>
<p>


Create a pod with the name of kplabs-nginx. The pod should be launched from an image of ``` mykplabs/kubernetes:nginx``` . The name of the container should be mycontainer

</details>

### Question 2: Multi-Container Pods

<details><summary>Expand The Question </summary>
<p>

Create a Multi-Container POD with the name of ```kplabs-multi-container```

There should be 3 containers as part of the pod. Name the first container as ```first-container```, 2nd container as ```second-container``` and 3rd container as ```third-container```

1st container should be launched from ```nginx``` image, second container should be launched from ```mykplabs/kubernetes:nginx``` image and third container from ```busybox``` image.

Connect to the first-container and run the following command:  ```apt-get update && apt-get install net-tools```

Connect to the third-container and identify the ports in which processes are listening. Perform wget command on those ports and check if you can download the HTML page.


</details>

### Question 3: Commands and Arguments

<details><summary>Expand The Question </summary>
<p>


Create a pod with the name of kplabs-cmdargs. The pod should be launched from an image of ```busybox``` . The name of the container should be cmdcontainer. Both the container image's CMD and ENTRYPOINT instruction should be overridden. 

The container should start with ```sleep``` command and argument of ```3600```
</details>


### Question 4: Exposing Ports for PODS

<details><summary>Expand The Question </summary>
<p>


Create a pod with the name of kplabs-ports. The pod should be launched from an image of ```nginx``` . The name of the container should be nginx. Expose Port ```80``` for the POD.

</details>

### Question 5: CLI Documentation

<details><summary>Expand The Question </summary>
<p>

1. List down all the available fields and it's associated description that we can include in a POD Manifest. Store data to pod.txt

2. List down all the fields & it's description that we can add under the metadata section under POD manifest. Store data to pod-manifest.txt

3. Matthew has realized that there is an option for ```tolerationSeconds``` under POD -> Spec -> Tolerations. Store the associated documentation for tolerationSeconds and store it under a file named tolerationSeconds.txt

</details>


### Question 6: Arguments

<details><summary>Expand The Question </summary>
<p>

Create a pod named ```kplabs-logging```

The Pod should have a container running from the nginx image with the following arguments:

    - /bin/sh
    - -c
    - >
      i=0;
      while true;
      do
        echo "$i: $(date)" >> /var/log/1.log;
        echo "$(date) INFO $i" >> /var/log/2.log;
        i=$((i+1));
        sleep 1;
      done

Once POD is created, connect to the POD and verify the contents of ```/var/log/1.log``` and ```/var/log/2.log```

</details>

### Question 7: POD Troubleshooting

<details><summary>Expand The Question </summary>
<p>

1. Create a POD with the name ```kplabs-troubleshoot```. Launch it from busybox image.
2. Once launch, verify if you can see pod in "Ready" state.
3. If it's not in ready state, find out what can be the reason.
4. Edit the POD manifest to make sure busybox pod is available for at-least next 10 minutes.
</details>

### Question 8: API Primitives

<details><summary>Expand The Question </summary>
<p>

1. Create a proxy connection via ```kubectl proxy --port 8080```

2. Verify from browser if you are able to see the list all the Kubernetes API's.

3. Find the list of resources under the ```/api/v1```

4. Find the list of all the PODS running within your Kubernetes environment,
</details>
