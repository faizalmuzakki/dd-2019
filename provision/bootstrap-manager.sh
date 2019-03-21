# Copy APT repositories
sudo cp '/vagrant/config/sources.list' '/etc/apt/sources.list'

# Update repositories
sudo apt-get update -y

#configure cluster manager
cd ~
wget https://dev.mysql.com/get/Downloads/MySQL-Cluster-7.6/mysql-cluster-community-management-server_7.6.9-1ubuntu16.04_amd64.deb
sudo dpkg -i mysql-cluster-community-management-server_7.6.9-1ubuntu16.04_amd64.deb
sudo mkdir /var/lib/mysql-cluster
sudo cp '/vagrant/config/ndb-manager/config.ini' '/var/lib/mysql-cluster/config.ini'
sudo ndb_mgmd -f /var/lib/mysql-cluster/config.ini
sudo pkill -f ndb_mgmd
sudo cp '/vagrant/config/ndb-manager/ndb_mgmd.service' '/etc/systemd/system/ndb_mgmd.service'
sudo systemctl daemon-reload
sudo systemctl enable ndb_mgmd
sudo systemctl start ndb_mgmd
# sudo systemctl status ndb_mgmd

sudo ufw allow from 192.168.33.12
sudo ufw allow from 192.168.33.13
sudo ufw allow from 192.168.33.14

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

# sudo cp '/vagrant/sample_db.sql' '~/sample_db.sql'
# mysql -u root -p root < sample_db.sql

# set proxysql
mysql -u root -proot < /vagrant/config/servicenode/addition_to_sys.sql
mysql -u root -proot < /vagrant/config/servicenode/create_proxy_user.sql
