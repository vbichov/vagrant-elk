# -*- mode: ruby -*-
# vi: set ft=ruby :

EXPOSED_PORTS = [
    9200, # Elasticsearch
    9300, # Elasticsearch
    5000, # Logtash
    5601  # Kibana
  ]

Vagrant.configure("2") do |config|

    config.vm.provider "virtualbox" do |vb|
        vb.cpus = 2
        vb.memory = 4096
    end
    # configure VM
    config.vm.box = "bento/ubuntu-18.04"

    config.vm.define :elk do |node|
        node.vm.box = "bento/ubuntu-18.04"
        node.vm.hostname = "elk"
        node.vm.network "private_network", ip: "192.168.50.4"
        EXPOSED_PORTS.each do | port|
          node.vm.network "forwarded_port", guest: port , host: port
        end
        node.vm.provision "shell", path: "bootstrap_elk.sh", privileged: true
    end

    config.vm.define :grafana do |node|
        node.vm.box = "bento/ubuntu-18.04"
        node.vm.hostname = "grafana"
        node.vm.network "private_network", ip: "192.168.50.5"
        node.vm.network "forwarded_port", guest: 3000 , host: 3000
        node.vm.provision "shell", path: "bootstrap_grafana.sh", privileged: true
    end


end
