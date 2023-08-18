#!/bin/bash

cd ~
sudo yum install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo git clone https://github.com/Micah-Shallom/BalanceeAutoDeploy.git
sudo cp BalanceeAutoDeploy/infrastructure/prod/ami/reverseProxy.conf /etc/nginx/
sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf-distro
cd /etc/nginx/
sudo touch nginx.conf
sudo sed -n 'w nginx.conf' reverseProxy.conf
sudo systemctl restart nginx
sudo rm -rf reverseProxy.conf