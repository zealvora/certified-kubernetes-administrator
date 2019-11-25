### Question 1: Labels

<details><summary>Expand The Question </summary>
<p>

Create a pod named kplabs-label. The pod should be launched from ```nginx``` image. The name of container should be ```nginx-container```. Attach following label to the pod. 
```sh
env=production
app=webserver
```
</details>

### Question 2: Deployments

<details><summary>Expand The Question </summary>
<p>

Create a deployment named ```kplabs-deployment```. The deployment should be launched from ```nginx``` image. The deployment should be three replicas. The selector should be based on the label of ```app=nginx```
</details>

### Question 3: Deployments - Rolling Updates and Rollbacks

<details><summary>Expand The Question </summary>
<p>

Create a deployment named ```kplabs-update```. The deployment should be launched from ```nginx``` image. There should be two  replicas. Verify the status of the deployment. As part of rolling update, update the image to ```nginx2:alpine```. Verify the status of deployment. Perform a rollback to the previous versio. Verify the status of deployment.
</details>

### Question 4: Readiness Probe

<details><summary>Expand The Question </summary>
<p>

Launch a pod from the ```nginx``` image. Create a readiness probe for the pod.
</details>

### Question 5: Labels and Selectors

<details><summary>Expand The Question </summary>
<p>

Create a deployment named ```kplabs-selector```. The pods should be launched from ```nginx``` image.The pods should only be launched in a node which has a label of ```disk=ssd```. Observe the status of deployment. Add the appropriate label to the worker node and then observe the status of the deployment.

</details>

### Question 6:  CronJob

<details><summary>Expand The Question </summary>
<p>
  
Create a job named ```kplabs-job```. The job should run every minute and should print out the current date.

</details>
