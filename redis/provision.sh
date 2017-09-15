#!/bin/sh

_PROVISIONER_DIR='/home/vagrant/app/vagrant'
_REDIS_PATH='/etc/redis'
_REDIS_CONFIG_PATH="${_REDIS_PATH}/redis.conf"
_REDIS_CONFIG_TEMPLATE_PATH="${_PROVISIONER_DIR}/redis/redis.conf"
_REDIS_SERVICE_PATH="/etc/systemd/system/redis.service"
_REDIS_SERVICE_TEMPLATE_PATH="${_PROVISIONER_DIR}/redis/redis.service"



# Install build tools
apt-get install -y build-essential tcl

# Move to temp directory
cd /tmp

# Download Redis stable version
curl -O http://download.redis.io/redis-stable.tar.gz

# Unpack the tarball
tar xzvf redis-stable.tar.gz

# Move into the Redis source directory structure that was just extracted
cd redis-stable

# Compile Redis
make

# Install the binaries into the system
make install

# Create a config directory
mkdir /etc/redis

# Copy config file
rm -rf $_REDIS_CONFIG_PATH
cp $_REDIS_CONFIG_TEMPLATE_PATH $_REDIS_CONFIG_PATH

# Copy service file
rm -rf $_REDIS_SERVICE_PATH
cp $_REDIS_SERVICE_TEMPLATE_PATH $_REDIS_SERVICE_PATH

# Create Redis user
adduser --system --group --no-create-home redis

# Create Redis lib dir
mkdir /var/lib/redis

# Update redis lib dir owner and mode
chown redis:redis /var/lib/redis
chmod 770 /var/lib/redis

# Reload daemons
systemctl daemon-reload

# Start Redis
systemctl start redis

# Enable Redis
systemctl enable redis
