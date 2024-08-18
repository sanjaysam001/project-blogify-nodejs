1. **Create a file named blogify-deployment.yaml**   #already created
   ```- kubectl apply -f blogify-deployment.yaml```
2. **Create a file named blogify-service.yaml**       #already created
   ```- kubectl apply -f blogify-service.yaml```
3. **Install the NGINX Ingress Controller:**
   ``` - kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml```

4. **Create the Ingress resource named blogify-ingress.yaml**

```-----
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: blogify-ingress
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: blogify-service
            port: 
              number: 8000
 ---
   ```   
Apply it using - ```kubectl apply -f blogify-ingress.yaml```

5. **commands to check your ingress**
    ```
    - kubectl get deployments
    - kubectl get services
    - kubectl get ingress -A
    - kubectl get services -n ingress-nginx```

Look for the ingress-nginx-controller service's EXTERNAL-IP.
You should now be able to access your application using this IP or hostname:
   - http://<ingress-controller-ip>    
   - kubectl logs -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx
