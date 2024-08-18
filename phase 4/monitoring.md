**Installing prometheus and grafana using helm**

Installs the kube-prometheus stack, a collection of Kubernetes manifests, Grafana dashboards, and Prometheus rules combined with documentation and scripts to provide easy to operate end-to-end Kubernetes cluster monitoring with Prometheus using the Prometheus Operator.See the kube-prometheus README for details about components, dashboards, and alerts.

Note: This chart was formerly named prometheus-operator chart, now renamed to more clearly reflect that it installs the kube-prometheus project stack, within which Prometheus Operator is only one component.

**Prerequisites**
1. Kubernetes 1.19+
2. Helm 3+

Get Helm Repository Info
   ```
    - helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    - helm repo update
   ```
                        

create a seperate namespace for better structure of code
  ```
    - kubectl create namespace monitoring
  ```

Install Helm Chart
  ``` 
  - helm install [RELEASE_NAME] prometheus-community/kube-prometheus-stack  -n monitoring
``` 


Uninstall Helm Chart
  ```
      - helm uninstall [RELEASE_NAME] prometheus-community/kube-prometheus-stack -n monitoring 
  ```


Now , expose your grafana service to access it from your browser by changing the type to "LoadBalancer"
   
  ```
     - kubectl patch service grafana -p '{"spec": {"type": "LoadBalancer"}}'
  ```

 you will get an external ip , use it to access the grafana console using the web browser. 

 The credentials will be :
  
   - username = admin
   - password = prom-operator

 Generate password if wrong:
```
   - kubectl get secret grafana-admin-password -o jsonpath="{.data.admin-password}" | base64 -- 
    decode
 ```

**Add Prometheus as a Data Source:**

   - In Grafana, go to Configuration > Data Sources > Add - data source.
   - Select Prometheus.
   - Enter the Prometheus URL, typically http://prometheus-server:80 if using the default Helm installation.
   - Click Save & Test to confirm the connection.

**Import a Kubernetes Monitoring Dashboard:**

Grafana provides pre-built dashboards that you can import:

   - Go to Create > Import.
   - Use the dashboard ID 3119 for the Kubernetes cluster monitoring (via Prometheus) or search for other relevant dashboards.
   - Click Load, then select your Prometheus data source.
   - Click Import to add the dashboard to your Grafana.

Customize Your Dashboard:

   - After importing, you can customize the dashboard:
   - Add or remove panels based on your requirements.
   - Edit existing panels to display specific metrics like CPU, memory usage, network traffic, etc.
   - To add a new panel, click Add panel in the dashboard and configure the query and visualization type.

Set Up Alerts:

   - Go to a panel and click on the panel title, then select Edit.
   - Navigate to the Alert tab.
   - Set conditions for alerts (e.g., CPU usage > 80%).
   - Configure notification channels (email, Slack, etc.).
   - Save the alert configuration.
   - Save and Share Your Dashboard:

Once the dashboard is set up, click Save to preserve the configuration.
Share the dashboard with your team using the Share option, which provides a link or the option to export the JSON model.
Regular Monitoring and Updates:

Regularly monitor your Grafana dashboards for the health of your Kubernetes cluster.
Update your dashboards as your infrastructure grows or changes   
  


