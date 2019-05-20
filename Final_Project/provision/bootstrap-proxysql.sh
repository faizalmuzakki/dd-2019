# Update repositories
sudo apt-get update -y

# install proxysql from temporary file
cd /tmp
curl -OL https://github.com/sysown/proxysql/releases/download/v1.4.4/proxysql_1.4.4-ubuntu16_amd64.deb
sudo dpkg -i proxysql_*
rm proxysql_*

sudo apt-get update
sudo apt-get install mysql-client -y

sudo systemctl start proxysql

sudo ufw allow from 192.168.33.11
sudo ufw allow from 192.168.33.12
sudo ufw allow from 192.168.33.13
# systemctl status proxysql

# set proxysql
mysql -u admin -p admin -h 127.0.0.1 -P 6032 --prompt='ProxySQLAdmin> ' < /vagrant/config/proxysql/add_mysql_node.sql

# LOAD ADMIN VARIABLES TO RUNTIME;
# SAVE ADMIN VARIABLES TO DISK;
