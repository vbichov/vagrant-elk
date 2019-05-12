#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

GRAFANA_VERSION="6.1.6"

# update apt
apt-get update --quiet
apt-get install -y unzip git ifupdown apt-transport-https --quiet

# install the Grafana PGP Key and repo
curl -s https://packages.grafana.com/gpg.key | sudo apt-key add -
add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"

# install the elk PGP Key and repo
curl -s https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
add-apt-repository "deb https://artifacts.elastic.co/packages/7.x/apt stable main" 

apt-get update --quiet
echo "[*] Installing Grafana"
apt-get -y --quiet install grafana=$GRAFANA_VERSION


# copy over configs
cp /vagrant/configs/grafana/grafana.ini /etc/grafana/
/bin/systemctl daemon-reload
/bin/systemctl enable grafana-server.service
/bin/systemctl start grafana-server.service

sleep 10
# Smoke tests
netstat -pant
curl -XGET -s  http://localhost:3000
