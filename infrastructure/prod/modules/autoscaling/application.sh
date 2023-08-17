#!/bin/bash
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum install -y dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm
sudo yum install -y mysql wget vim telnet htop git python3 net-tools httpd
sudo systemctl start chronyd
sudo systemctl enable chronyd

# selinux config
sudo setsebool -P httpd_can_network_connect=1
sudo setsebool -P httpd_can_network_connect_db=1
sudo setsebool -P httpd_execmem=1
sudo setsebool -P httpd_use_nfs=1

#installing self signed certificate for apache
sudo yum install -y mod_ssl

sudo openssl req -newkey rsa:2048 -nodes -keyout /etc/pki/tls/private/balancee.key -x509 -days 365 -out /etc/pki/tls/certs/balancee.crt \
-subj "/C=NG/ST=Nigeria/L=Nigeria/O=mshallom/OU=devops/CN=$(curl -s http://169.254.169.254/latest/meta-data/local-hostname)"

sudo sed -i 's/localhost.crt/balancee.crt/g'  /etc/httpd/conf.d/ssl.conf

sudo sed -i 's/localhost.key/balancee.key/g'  /etc/httpd/conf.d/ssl.conf

sudo systemctl start httpd