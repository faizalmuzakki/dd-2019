# Instalasi Cassandra Single Node

## Outline
1. [Konfigurasi Vagrant](#konfigurasi-vagrant)
2. [Instalasi Oracle Java Virtual Machine](#instalasi-oracle-java-virtual-machine)
3. [Instalasi Cassandra](#instalasi-cassandra)
4. [Cek Koneksi Cluster](#cek-koneksi-cluster)

## Konfigurasi Vagrant
Konfigurasi bisa dilihat di [sini](Vagrantfile)

## Instalasi Oracle Java Virtual Machine
1. ssh ke node yang telah dibuat
    - `vagrant ssh cassandra1`
2. jalankan perintah ini di terminal
    - `sudo add-apt-repository ppa:webupd8team/java`
    - `sudo apt-get update`
    - `sudo apt-get install oracle-java8-set-default`
    - `java -version` (opsional, untuk mengecek ulang apakah java telah diinstall)

    ![java](ss/java.png)

## Instalasi Cassandra
- jalankan di terminal
    - `echo "deb http://www.apache.org/dist/cassandra/debian 22x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list`
    - `echo "deb-src http://www.apache.org/dist/cassandra/debian 22x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list`
    - `gpg --keyserver pgp.mit.edu --recv-keys F758CE318D77295D`
    - `gpg --export --armor F758CE318D77295D | sudo apt-key add -`
    - `gpg --keyserver pgp.mit.edu --recv-keys 2B5C1B00`
    - `gpg --export --armor 2B5C1B00 | sudo apt-key add -`
    - `gpg --keyserver pgp.mit.edu --recv-keys 0353B12C`
    - `gpg --export --armor 0353B12C | sudo apt-key add -`
    - `sudo apt-get update`
    - `sudo apt-get install cassandra`

    ![cassandra](ss/cassandra.png)

## Cek Koneksi Cluster
1. Mengecek status cluster
    - `sudo nodetool status`

    ![nodetool_status](ss/nodetool_status.png)

    - `cqlsh`

    ![cqlsh](ss/cqlsh.png)
