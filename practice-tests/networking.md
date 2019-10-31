### Question 1: Service

<details><summary>Expand The Question </summary>
<p>

Create a deployment named kplabs-service. The deployment should have three replicas and the image should be based on nginx. Create a service based on NodePort. The service port should be 8080. Verify if you are able to see the index.html of Nginx from service port.

</details>

### Question 2: Service and Endpoints

<details><summary>Expand The Question </summary>
<p>

Create a deployment named deployment-manual. Launch 3 replicas of nginx image. Create a service named service-manual. Create an endpoint with the IP address of all the pods of deployment-manual and associate it with service-manual. Verify the endpoints of the service to check if IP addresses have been populated.
</details>

### Question 3: Load Balanacer Service

<details><summary>Expand The Question </summary>
<p>

Create a deployment named kplabs-dmz. There should be 2 replicas of nginx image as part of the deployment. Create a service name service-elb and it should be based on LoadBalancer type. The Load Balancer should list on Port 80. Once launched, verify that the nginx default page load when you open the Load Balancer IP in browser.

</details>
