# Copy APT repositories
sudo cp '/vagrant/config/sources.list' '/etc/apt/sources.list'

# Update repositories
sudo apt-get update -y

#configure cluster manager
cd ~
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster-community-data-node_7.6.9-1ubuntu16.04_amd64.deb
sudo apt update

# dependency
# wget http://archive.ubuntu.com/ubuntu/pool/main/p/perl/perl-base_5.22.1-9_amd64.deb
# sudo dpkg -i perl-base_5.22.1-9_amd64.deb

sudo apt install libclass-methodmaker-perl
# sudo apt --fix-broken install -y
# sudo apt install libclass-methodmaker-perl
# sudo apt --fix-broken install -y
# sudo apt install libclass-methodmaker-perl
sudo dpkg -i mysql-cluster-community-data-node_7.6.9-1ubuntu16.04_amd64.deb
sudo cp '/vagrant/config/datanode/my.cnf' '/etc/my.cnf'
sudo mkdir -p /usr/local/mysql/data
sudo ndbd
sudo ufw allow from 192.168.33.11
sudo ufw allow from 192.168.33.12
sudo pkill -f ndbd
sudo cp '/vagrant/config/datanode/ndb_mgmd.service' '/etc/systemd/system/ndbd.service'
sudo systemctl daemon-reload
sudo systemctl enable ndbd
sudo systemctl start ndbd
sudo systemctl status ndbd
