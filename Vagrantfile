# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "first" do |first|
    # Box Settings
    first.vm.box = "bento/ubuntu-16.04"
    first.vm.hostname = "first"

    # Provider Settings
    first.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = false
      vb.name = "first"
      # Customize the amount of memory on the VM:
      vb.memory = "1024"
    end

    # Network Settings
    # first.vm.network "forwarded_port", guest: 80, host: 8080
    # first.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    first.vm.network "private_network", ip: "198.51.100.0"
    # first.vm.network "public_network"

    # Folder Settings
    # first.vm.synced_folder "../data", "/vagrant_data"

    # Provision Settings
    # first.vm.provision "shell", inline: <<-SHELL
    #   apt-get update
    #   apt-get install -y apache2
    # SHELL
    first.vm.provision "shell", path: "provision/bootstrap-first.sh", privileged: false
  end

  config.vm.define "second" do |second|
    # Box Settings
    second.vm.box = "bento/ubuntu-16.04"
    second.vm.hostname = "second"

    # Provider Settings
    second.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = false
      vb.name = "second"
      # Customize the amount of memory on the VM:
      vb.memory = "1024"
    end

    # Network Settings
    # second.vm.network "forwarded_port", guest: 80, host: 8080
    # second.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    second.vm.network "private_network", ip: "198.51.100.1"
    # second.vm.network "public_network"

    # Folder Settings
    # second.vm.synced_folder "../data", "/vagrant_data"

    # Provision Settings
    # second.vm.provision "shell", inline: <<-SHELL
    #   apt-get update
    #   apt-get install -y apache2
    # SHELL
    second.vm.provision "shell", path: "provision/bootstrap-second.sh", privileged: false
  end

  config.vm.define "third" do |third|
    # Box Settings
    third.vm.box = "bento/ubuntu-16.04"
    third.vm.hostname = "third"

    # Provider Settings
    third.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = false
      vb.name = "third"
      # Customize the amount of memory on the VM:
      vb.memory = "1024"
    end

    # Network Settings
    # third.vm.network "forwarded_port", guest: 80, host: 8080
    # third.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
    third.vm.network "private_network", ip: "198.51.100.2"
    # third.vm.network "public_network"

    # Folder Settings
    # third.vm.synced_folder "../data", "/vagrant_data"

    # Provision Settings
    # third.vm.provision "shell", inline: <<-SHELL
    #   apt-get update
    #   apt-get install -y apache2
    # SHELL
    third.vm.provision "shell", path: "provision/bootstrap-third.sh", privileged: false
  end

end
