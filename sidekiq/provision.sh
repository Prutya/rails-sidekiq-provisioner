#!/bin/sh

_PROVISIONER_DIR='/home/vagrant/app/vagrant'

_TEMPLATE_PATH="${_PROVISIONER_DIR}/sidekiq/sidekiq.service"
_CONFIG_DIR='/usr/lib/systemd/system'
_CONFIG_PATH="${_CONFIG_DIR}/sidekiq.service"

# Replace the old config
mkdir $_CONFIG_DIR
rm -rf $_CONFIG_PATH
cp $_TEMPLATE_PATH $_CONFIG_PATH

# Reload deamons
systemctl daemon-reload

# Start Sidekiq
systemctl start sidekiq

# Enable sidekiq
systemctl enable sidekiq
