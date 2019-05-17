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

sudo apt install libclass-methodmaker-perl -y
# sudo apt --fix-broken install -y
# sudo apt install libclass-methodmaker-perl
# sudo apt --fix-broken install -y
# sudo apt install libclass-methodmaker-perl
sudo dpkg -i mysql-cluster-community-data-node_7.6.9-1ubuntu16.04_amd64.deb
sudo cp '/vagrant/config/datanode/my.cnf' '/etc/my.cnf'
sudo mkdir -p /usr/local/mysql/data
sudo ndbd

sudo ufw allow from 192.168.33.11
sudo ufw allow from 192.168.33.13
sudo ufw allow from 192.168.33.14

sudo pkill -f ndbd
sudo cp '/vagrant/config/datanode/ndb_mgmd.service' '/etc/systemd/system/ndbd.service'
sudo systemctl daemon-reload
sudo systemctl enable ndbd
sudo systemctl start ndbd
# sudo systemctl status ndbd

#configuring and starting mysql server & client
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster_7.6.9-1ubuntu16.04_amd64.deb-bundle.tar
mkdir install
tar -xvf mysql-cluster_7.6.9-1ubuntu16.04_amd64.deb-bundle.tar -C install/
cd install
sudo apt update
sudo apt install libaio1 libmecab2

sudo dpkg -i mysql-common_7.6.9-1ubuntu16.04_amd64.deb
sudo dpkg -i mysql-cluster-community-client_7.6.9-1ubuntu16.04_amd64.deb
sudo dpkg -i mysql-client_7.6.9-1ubuntu16.04_amd64.deb
sudo dpkg -i mysql-cluster-community-server_7.6.9-1ubuntu16.04_amd64.deb

sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/root-pass password root'
sudo debconf-set-selections <<< 'mysql-community-server mysql-community-server/re-root-pass password root'

sudo dpkg -i mysql-server_7.6.9-1ubuntu16.04_amd64.deb
sudo cp '/vagrant/config/servicenode/my.cnf' '/etc/mysql/my.cnf'
sudo systemctl restart mysql
sudo systemctl enable mysql

#set proxysql
mysql -u root -proot < /vagrant/config/servicenode/addition_to_sys.sql
mysql -u root -proot < /vagrant/config/servicenode/create_proxy_user.sql
