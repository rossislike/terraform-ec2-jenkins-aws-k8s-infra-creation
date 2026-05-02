#!/bin/bash

# Install Updated packages on linux machine
sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y
#sudo yum install jenkins java-1.8.0-openjdk-devel -y
#sudo amazon-linux-extras install java-openjdk11
#Java 21 installed and old Java versions commented out
sudo dnf install java-21-amazon-corretto-devel -y
sudo yum install git -y
sudo yum install nodejs npm -y
sudo dnf install maven -y
curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | sudo bash
sudo update-alternatives --set java /usr/lib/jvm/java-21-amazon-corretto.x86_64/bin/java
sudo yum install jenkins -y
sudo sed -i -e 's/Environment="JENKINS_PORT=[0-9]\+"/Environment="JENKINS_PORT=8081"/' /usr/lib/systemd/system/jenkins.service
sudo systemctl daemon-reload
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
sudo yum install unzip -y
sudo unzip awscliv2.zip  
sudo ./aws/install
#ZAP is installed and can be run as zap.sh
sudo wget https://github.com/zaproxy/zaproxy/releases/download/v2.17.0/ZAP_2_17_0_unix.sh
sudo chmod +x ZAP_2_17_0_unix.sh 
sudo ./ZAP_2_17_0_unix.sh -q
curl -o kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.35.3/2026-04-08/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
sudo cp kubectl /usr/local/bin/
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
sudo yum install docker -y
sudo usermod -aG docker $USER
sudo usermod -aG docker jenkins
sudo systemctl start docker
sudo systemctl enable docker
sudo yum install jq -y
sudo systemctl daemon-reload
sudo systemctl restart jenkins
