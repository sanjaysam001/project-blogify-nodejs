**Steps to create a firewall policy in Google Cloud Platform (GCP) to add the ports for our blogify nodejs application:**

1. Open the Google Cloud Console (console.cloud.google.com)
2. Navigate to "VPC network" > "Firewall"
3. Click "Create Firewall Rule"
4. Configure the new rule:

     - Name: Give it a descriptive name (e.g. "allow-common-ports")
     - Network: Select your VPC network
     - Priority: Set a priority (lower number = higher priority)
     - Direction of traffic: "Ingress"
     - Action on match: "Allow"
     - Targets: "All instances in the network" (or specify tags if needed)
     - Source filter: IP ranges
     - Source IP ranges: 0.0.0.0/0 (to allow from anywhere, like in the image)
     - Protocols and ports: Specify multiple ports
        **TCP: 25,80,443,22,6443,465,3000-10000,30000-32767**



5. Click "Create"

This will create a firewall rule allowing inbound traffic on the specified ports from any source IP.