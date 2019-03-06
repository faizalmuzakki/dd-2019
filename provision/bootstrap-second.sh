# Changing the APT sources.list to kambing.ui.ac.id
sudo cp '/vagrant/config/sources.list' '/etc/apt/sources.list'

# Updating the repo with the new sources
sudo apt-get update -y

# Setting input for MySQL root password
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password admin'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password admin'

# Install MySQL Server
sudo apt-get install mysql-server mysql-client -y

# Copy MySQL configuration
# sudo cp '/vagrant/config/mysqld-second.cnf' '/etc/mysql/mysql.conf.d/mysqld.cnf'

# Restart MySQL service
sudo service mysql restart
