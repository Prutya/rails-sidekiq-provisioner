#!/bin/sh

_DB_USER='vagrant'
_DB_DEV_NAME='app_dev'
_DB_TEST_NAME='app_test'



# Install PostgreSQL packages
apt-get install -y postgresql postgresql-contrib libpq-dev

# Create a database user as a superuser (-s)
su - -c "createuser -s ${_DB_USER}" postgres

# Create databases
su - -c "createdb -O ${_DB_USER} ${_DB_DEV_NAME}" postgres
su - -c "createdb -O ${_DB_USER} ${_DB_TEST_NAME}" postgres
