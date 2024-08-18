**Steps to create two VMs in Google Cloud Platform (GCP) for Jenkins and SonarQube:**

1. Access GCP Console:

   - Go to https://console.cloud.google.com/
   - Sign in or create an account


2. Create a new project or select an existing one
   - Enable Compute Engine API:

3. Navigate to "APIs & Services" > "Dashboard"
   - Click "Enable APIs and Services"
   - Search for "Compute Engine API" and enable it


4. Create VMs:

   - Go to "Compute Engine" > "VM instances"
   - Click "Create Instance"


5. Configure Jenkins VM:

    - Name: jenkins-vm
    - Region: Choose nearest to you
    - Machine type: e2-medium (2 vCPU, 4 GB memory)
    - Boot disk: Ubuntu 22.04 LTS
    - persistent disk: 40GB
    - Allow HTTP and HTTPS traffic
    - Click "Create"


6. Configure SonarQube VM:

7. Repeat steps for Jenkins VM, but name it sonarqube-vm


8. SSH into VMs:

Click the SSH button next to each VM in the GCP console

