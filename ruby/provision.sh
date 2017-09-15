#!/bin/sh

_RUBY_VERSION="$(cat ~/app/.ruby-version)" # Read Ruby version from .ruby-version



# Get gpg keys for RVM
command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -

# Get rvm
curl -sSL https://get.rvm.io | bash -s stable

# Source the RVM
source ~/.rvm/scripts/rvm

# Install Ruby
rvm install $_RUBY_VERSION

gem install bundler --no-ri --no-rdoc
