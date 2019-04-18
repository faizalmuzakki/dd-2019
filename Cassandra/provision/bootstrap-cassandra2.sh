# Copy APT repositories
# sudo cp '/vagrant/config/sources.list' '/etc/apt/sources.list'

# Update repositories
sudo apt-get update -y

# install lib for add apt
sudo apt-get install software-properties-common -y

# install java
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -y
sudo apt-get install oracle-java8-set-default -y

# install cassandra
echo "deb http://www.apache.org/dist/cassandra/debian 39x main" |  tee /etc/apt/sources.list.d/cassandra.list
gpg --keyserver pgp.mit.edu --recv-keys 749D6EEC0353B12C
gpg --export --armor 749D6EEC0353B12C | apt-key add -
gpg --keyserver pgp.mit.edu --recv-keys A278B781FE4B2BDA
gpg --export --armor A278B781FE4B2BDA | apt-key add -
sudo apt-get update
sudo apt-get install cassandra -y
