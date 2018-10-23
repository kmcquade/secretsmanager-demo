#!/bin/bash

# ======== Installations ========

echo "Installing jq"
sudo curl --silent -Lo /bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
sudo chmod +x /bin/jq
echo "Setting timezone to UTC"
sudo timedatectl set-timezone UTC
sudo apt-get -qq -y update
sudo apt-get install -qq -y wget unzip dnsutils ruby rubygems ntp git nodejs-legacy npm nginx
sudo systemctl start ntp.service
sudo systemctl enable ntp.service
echo "Disable reverse dns lookup in SSH"
sudo sh -c 'echo "\nUseDNS no" >> /etc/ssh/sshd_config'

echo "Performing updates and installing prerequisites"
sudo apt-get -qq -y update
curl -O https://bootstrap.pypa.io/get-pip.py
python get-pip.py
pip install awscli
aws --version

# ======== Grabbing the certificates via AWS Secrets Manager ========

aws configure set default.region ${aws_region}

echo "Here is the variable interpolated value: ${ca_crt}"
echo "Storing secret value for ca_crt in /opt"
aws secretsmanager get-secret-value --secret-id ${ca_crt} --query 'SecretString' --output text >> /opt/ca_crt.pem

echo "Storing secret value for ca_crt in /opt"
aws secretsmanager get-secret-value --secret-id ${leaf_crt} --query 'SecretString' --output text>> /opt/leaf_crt.pem

echo "Storing secret value for ca_crt in /opt"
aws secretsmanager get-secret-value --secret-id ${leaf_key} --query 'SecretString' --output text >> /opt/leaf_key.pem
