To set up SSL/TLS for our domain blogify-main.devilops.in we will be using a free certificate, we'll use cert-manager to automatically obtain and manage Let's Encrypt certificates. H

1. **Install cert-manager:**
      - kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml

2. **Create an Issuer (or ClusterIssuer) for Let's Encrypt named letsencrypt-issuer.yaml:**

-----
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: your-email@example.com  # Replace with your email
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx

------          
Apply it using - kubectl apply -f letsencrypt-issuer.yaml

3. **Create or update your Ingress file (blogify-ingress.yaml):**
   
---    
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: blogify-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
spec:
  tls:
  - hosts:
    - blogify-main.devilops.in        #change it with yours
    secretName: blogify-tls-secret
  rules:
  - host: blogify-main.devilops.in     #change it with yours
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: blogify-ssvc
            port: 
              number: 8000  # Adjust if your service port is different
---              
Apply it using - kubectl apply -f blogify-ingress.yaml

4. **Verify and Check the status of the certificate:**
    - kubectl get certificate
    (You should see a certificate named blogify-tls in the Ready state after a few minutes.)

5. **Once the certificate is ready, you should be able to access your application securely:**

     - https://blogify-main.devilops.in   #your domain 
     - kubectl logs -n cert-manager -l app=cert-manager

