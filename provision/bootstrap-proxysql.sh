# Copy APT repositories
sudo cp '/vagrant/config/sources.list' '/etc/apt/sources.list'

# Update repositories
sudo apt-get update -y

# install proxysql from temporary file
cd /tmp
curl -OL https://github.com/sysown/proxysql/releases/download/v1.4.4/proxysql_1.4.4-ubuntu16_amd64.deb
sudo dpkg -i proxysql_*
rm proxysql_*

sudo apt-get update
sudo apt-get install mysql-client

sudo systemctl start proxysql
systemctl status proxysql
