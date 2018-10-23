#!/bin/bash

CONSUL_TLS_DIR=/opt/consul/tls
CONSUL_CONFIG_DIR=/etc/consul.d
VAULT_TLS_DIR=/opt/vault/tls

echo "Create TLS dirs for certs"
sudo mkdir -pm 0755 $CONSUL_TLS_DIR $VAULT_TLS_DIR

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

# ======== Grabbing the certificates, which are passed in cleartext userdata ========

aws configure set default.region ${aws_region}

echo "Write certs to TLS directories"
cat <<EOF | sudo tee $CONSUL_TLS_DIR/consul-ca.crt $VAULT_TLS_DIR/vault-ca.crt
${ca_crt}
EOF
cat <<EOF | sudo tee $CONSUL_TLS_DIR/consul.crt $VAULT_TLS_DIR/vault.crt
${leaf_crt}
EOF
cat <<EOF | sudo tee $CONSUL_TLS_DIR/consul.key $VAULT_TLS_DIR/vault.key
${leaf_key}
EOF
