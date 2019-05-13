sudo apt-get update -y
sudo apt-get install build-essential tcl -y
sudo apt-get install libjemalloc-dev -y # (Optional)
curl -O http://download.redis.io/redis-stable.tar.gz
sudo tar xzvf redis-stable.tar.gz
cd redis-stable
sudo make
sudo make test
sudo make install

sudo ufw allow 6379
sudo ufw allow 26379
sudo ufw allow from 192.168.33.10
sudo ufw allow from 192.168.33.11
sudo ufw allow from 192.168.33.12
