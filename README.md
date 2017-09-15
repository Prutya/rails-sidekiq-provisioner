# Rails provisioner

This is a [Vagrant](https://www.vagrantup.com) VM provisioner for [Ruby on Rails](https://www.vagrantup.com) stack, targeted for [Ubuntu](https://www.ubuntu.com) 16.04 boxes.

Tested on macOS Sierra.

## What is in there?
#### [Ruby](https://www.ruby-lang.org/en/)
Tested on **Ruby 2.4.1**
#### [RVM](https://rvm.io)
#### [PostgreSQL](https://www.postgresql.org)
Two databases are being created: **app_dev** and **app_test**, both for **vagrant** user.
#### [Redis](https://redis.io)
Redis is being built from source and set up as a [systemd](https://en.wikipedia.org/wiki/Systemd) service.
#### [Sidekiq](http://sidekiq.org)
Sidekiq is set up as a [systemd](https://en.wikipedia.org/wiki/Systemd) service.
#### [Imagemagick](https://www.imagemagick.org/script/index.php)
Assuming you do some image processing in your Rails app.

## Usage
Populate you [**Gemfile**](http://bundler.io/gemfile.html) with required gems.

```ruby
# ./Gemfile

# ...
gem 'pg',              '~> 0.18'
gem 'rails',           '~> 5.1.3'
gem 'rest-client',     '~> 2.0.2'
gem 'sidekiq',         '~> 5.0.4'
# ...
```

Clone this repository to your project folder and modify your [**Vagrantfile**](https://www.vagrantup.com/docs/vagrantfile/).

```ruby
# ./Vagrantfile

VAGRANT_API_VERSION = '2'

Vagrant.configure(VAGRANT_API_VERSION) do |config|
  # As this provisioner is built for usage on Ubuntu 16.04
  config.vm.box = 'bento/ubuntu-16.04'

  # Synced folder settings
  config.vm.synced_folder '.', '/home/vagrant/app'

  # ...

  config.vm.provision :shell do |s|
    # By convention, your provisioning scripts should be put into
    # the ./vagrant folder
    s.path = 'vagrant/provision.sh'
  end
  # ...
end
```

## Acknowledgements
This script would not have been created without the help of these articles. Thank you!

* [How To Install Ruby and Set Up a Local Programming Environment on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-and-set-up-a-local-programming-environment-on-ubuntu-16-04)
* [How to install PostgreSQL on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-16-04)
* [How To Install and Configure Redis on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-redis-on-ubuntu-16-04)
* [Properly setting up Redis and Sidekiq in production on Ubuntu 16.04](https://thomasroest.com/2017/03/04/properly-setting-up-redis-and-sidekiq-in-production-ubuntu-16-04.html)
