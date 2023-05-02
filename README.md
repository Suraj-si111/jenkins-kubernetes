Jenkins Deployment on Google Kubernetes Engine
This repository contains code to deploy Jenkins on Google Kubernetes Engine (GKE) using Kubernetes.

Prerequisites
Before you begin, make sure you have the following:

A Google Cloud Platform (GCP) account
gcloud command-line tool installed and authenticated
A GCP project with billing enabled
Docker installed on your local machine
kubectl command-line tool installed

Getting Started
Clone the repository:
 
`git clone https://github.com/Suraj-si111/jenkins-kubernetes.git`

Edit the deployment.yaml file and replace the image field with your own Docker image as per your requirements

Create a Kubernetes namespace for Jenkins:

`kubectl create namespace jenkins`
Create a Persistent Volume Claim (PVC) to store Jenkins data:
 
`kubectl apply -f pvc.yaml`
Build and push the Docker image to Google Container Registry:

 
`docker build -t gcr.io/YOUR-PROJECT-ID/custom-jenkins-docker:latest .`

`docker push gcr.io/YOUR-PROJECT-ID/custom-jenkins-docker:latest`

Make sure to replace YOUR-PROJECT-ID with your GCP project ID.

Deploy Jenkins using the deployment.yaml file:
 
`kubectl apply -f deployment.yaml`
Get the Jenkins URL by running the following command:
  
 
`kubectl get service jenkins -n jenkins`
Note down the EXTERNAL-IP of the jenkins service.

Access Jenkins using the URL in your browser. You will need to log in with the credentials admin/admin.
Contributing
Contributions are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.

License
This project is licensed under the MIT License - see the LICENSE.md file for details.

Acknowledgments

Jenkins

Google Kubernetes Engine
