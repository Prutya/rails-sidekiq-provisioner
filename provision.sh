#!/bin/sh

_APP_DIR='/home/vagrant/app'
_BASH_PROFILE='/home/vagrant/.bash_profile'
_PROVISIONER_DIR="${_APP_DIR}/vagrant"
_PROVISIONER_FILE_NAME="provision.sh"

_PROVISIONER_DIR_RUBY="${_PROVISIONER_DIR}/ruby"
_PROVISIONER_DIR_PSQL="${_PROVISIONER_DIR}/postgresql"
_PROVISIONER_DIR_REDIS="${_PROVISIONER_DIR}/redis"
_PROVISIONER_DIR_SIDEKIQ="${_PROVISIONER_DIR}/sidekiq"
_PROVISIONER_DIR_APP="${_PROVISIONER_DIR}/app"

_PROVISIONER_RUBY="${_PROVISIONER_DIR_RUBY}/${_PROVISIONER_FILE_NAME}"
_PROVISIONER_PSQL="${_PROVISIONER_DIR_PSQL}/${_PROVISIONER_FILE_NAME}"
_PROVISIONER_REDIS="${_PROVISIONER_DIR_REDIS}/${_PROVISIONER_FILE_NAME}"
_PROVISIONER_SIDEKIQ="${_PROVISIONER_DIR_SIDEKIQ}/${_PROVISIONER_FILE_NAME}"
_PROVISIONER_APP="${_PROVISIONER_DIR_APP}/${_PROVISIONER_FILE_NAME}"



# Refresh the local package index
apt-get update

# Install gnupg2 for RVM
apt-get install -y gnupg2

# Provision Ruby as vagrant user
su - -c "source ${_PROVISIONER_RUBY}" vagrant

# Provision PostgreSQL as root user
su - -c "source ${_PROVISIONER_PSQL}" root

# Provision Redis as root user
su - -c "source ${_PROVISIONER_REDIS}" root

# Provision App as vagrant user
su - -c "source ${_PROVISIONER_APP}" vagrant

# Provision Sidekiq as root user
su - -c "source ${_PROVISIONER_SIDEKIQ}" root

# Add dir change to the .bash_profile if not exists
if ! grep -e "cd ${_APP_DIR}" $_BASH_PROFILE ; then
  echo "cd ${_APP_DIR}" >> $_BASH_PROFILE
fi
