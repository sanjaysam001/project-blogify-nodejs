**Requirements**

- Installed kubectl command-line tool.
- Have a kubeconfig file (default location is ~/.kube/ config). 
- CoreDNS. Can be enabled for microk8s by microk8s enable dns && microk8s stop && microk8s start

1. **Install Argo CD**
```
  - kubectl create namespace argocd
  - kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

2. **Access The Argo CD API Server**
    By default, the Argo CD API server is not exposed with an external IP. To access the API server, choose one of the following techniques to expose the Argo CD API server:

     Service Type Load Balancer
    Change the argocd-server service type to LoadBalancer:  
   ``` 
     -  kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
    ```
3. **Port Forwarding**
   Kubectl port-forwarding can also be used to connect to the API server without exposing the service.
  ```
   - kubectl port-forward svc/argocd-server -n argocd 8080:443 
   ```
4.  **Add Your GitHub Repository to Argo CD:**

   - Navigate to Settings > Repositories in the Argo CD UI.
   - Click on Connect Repo Using HTTPS.
   - Enter the repository URL (e.g., https://github.com/your-username/my-app-deployment) and provide credentials if required.
   - Click Connect.

5. **Create a New Argo CD Application**
    Create Application via Argo CD UI:
    In the Argo CD UI, click on New App. 

Fill in the application details:

   - Application Name: my-app
   - Project: default
   - Sync Policy: Automatic or Manual depending on your preference.
   - Repository URL: Select the repository you added earlier.
   - Revision: HEAD or a specific branch.
   - Path: The directory in the repository containing the manifests (e.g., manifests/ or charts/).
   - Cluster: Select your Kubernetes cluster.

   - Namespace: The namespace where you want to deploy your application.

   - Click Create.

6.  **Sync the Application** 
   - Manual Sync (if chosen):

       - Go to the Applications section in the Argo CD UI.
       - Select my-app.
       - Click Sync to deploy the application manually.

   - Automatic Sync (if chosen):

       - Argo CD will automatically sync your application with the latest changes in the GitHub repository.   
