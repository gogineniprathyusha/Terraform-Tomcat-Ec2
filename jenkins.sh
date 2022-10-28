#!/bin/bash
sudo su --
yum update
amazon-linux-extras install -y java-openjdk11
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade
yum install jenkins -y
systemctl enable jenkins
systemctl start jenkins