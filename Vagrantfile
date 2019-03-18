# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  (1..3).each do |i|
    config.vm.define "clusterdb#{i}" do |node|
      node.vm.hostname = "clusterdb#{i}"
      node.vm.box = "bento/ubuntu-16.04"
      node.vm.network "private_network", ip: "192.168.33.1#{i}"

      # Opsional. Edit sesuai dengan nama network adapter di komputer
      # node.vm.network "public_network", bridge: "Qualcomm Atheros QCA9377 Wireless Network Adapter"

      node.vm.provider "virtualbox" do |vb|
        vb.name = "clusterdb#{i}"
        vb.gui = false
        vb.memory = "1024"
      end

      node.vm.provision "shell", path: "provision/bootstrap-clusterdb#{i}.sh", privileged: false
    end
  end

  config.vm.define "proxysql" do |node|
    node.vm.hostname = "proxysql"
    node.vm.box = "bento/ubuntu-16.04"
    node.vm.network "private_network", ip: "192.168.33.14"

    # Opsional. Edit sesuai dengan nama network adapter di komputer
    # node.vm.network "public_network", bridge: "Qualcomm Atheros QCA9377 Wireless Network Adapter"

    node.vm.provider "virtualbox" do |vb|
      vb.name = "proxysql"
      vb.gui = false
      vb.memory = "1024"
    end

    node.vm.provision "shell", path: "provision/bootstrap-proxysql.sh", privileged: false
  end
end
