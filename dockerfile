FROM jenkins/jenkins:lts
USER root

RUN id -g jenkins

RUN apt-get update -qq \
   && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable"
RUN apt-get update -qq \
   && apt-get -y install docker-ce
RUN usermod -aG docker jenkins

#Allow jenkins user to use sudo without a password for Docker commands
RUN echo 'jenkins ALL=(ALL) NOPASSWD: /usr/bin/docker' >> /etc/sudoers

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
RUN apt-get update -qq
RUN apt-get install -y google-cloud-sdk

RUN apt-get install -y google-cloud-sdk-gke-gcloud-auth-plugin

#Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
   && chmod +x kubectl \
   && mv kubectl /usr/local/bin/

RUN chown -R jenkins:jenkins /var/jenkins_home && chmod -R 777 /var/jenkins_home

USER jenkins
