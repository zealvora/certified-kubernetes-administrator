### Question 1: Creating Single Container Pods 

<details><summary>Expand The Question </summary>
<p>


Create a pod with the name of kplabs-nginx. The pod should be launched from an image of ``` mykplabs/kubernetes:nginx``` . The name of the container should be mycontainer

</details>

### Question 2: Question 2: Multi-Container Pods

<details><summary>Expand The Question </summary>
<p>

Create a Multi-Container POD with the name of kplabs-multi-container. 

There should be 3 containers as part of the pod. Name the first container as first-container, 2nd container as second-container and 3rd container as third-container

1st container should be launched from nginx image, second container should be launched from mykplabs/kubernetes:nginx image and third container from busybox image.

Connect to the first-container and run the following command:  ```apt-get update && apt-get install net-tools```

Connect to the third-container and identify the ports in which processes are listening. Perform wget command on those ports and check if you can download the HTML page.


</details>
