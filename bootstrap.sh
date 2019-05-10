#!/usr/bin/env bash

export DEBIAN_FRONTEND="noninteractive"

ELK_VERSION="7.0.1"

# update apt
apt-get update --quiet
apt-get install -y unzip git apt-transport-https default-jre --quiet

java -version
echo "Java Home is"
echo $JAVA_HOME

# install the Elastic PGP Key and repo
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list

apt-get update --quiet
echo "[*] Installing Elastic Search"
apt-get install --quiet -y elasticsearch=$ELK_VERSION 
echo "[+] Done Installing Elastic Search"


# copy over configs
cp /vagrant/configs/elasticsearch/elasticsearch.yml /etc/elasticsearch/
/bin/systemctl daemon-reload
/bin/systemctl enable elasticsearch.service
/bin/systemctl start elasticsearch.service

# install Logstash
echo "[*] Installing Logstash"
apt-get install  --quiet -y logstash=1:$ELK_VERSION-1 

# copy over configs
cp -R /vagrant/configs/logstash/* /etc/logstash/conf.d/
systemctl enable logstash.service
systemctl start logstash.service
echo "[+] Done Installing Logstash"


# Install Kibana
echo "[*] Installing Kibana"
apt-get install --quiet -y kibana=$ELK_VERSION 

# copy over configs
cp /vagrant/configs/kibana/kibana.yml /etc/kibana/

/bin/systemctl daemon-reload
/bin/systemctl enable kibana.service
systemctl start kibana.service
echo "[*] Done Installing Kibana"

# Smoke tests
netstat -pant
curl -XGET http://localhost:9200
