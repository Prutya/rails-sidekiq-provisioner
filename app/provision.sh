cd /home/vagrant/app

# Install gems
bundle install

# Migrate the database
rails db:migrate

# Seed the database
rails db:seed

# Copy dotenv file
cp .env.example .env

# Install ImageMagick
sudo apt-get install -y imagemagick
