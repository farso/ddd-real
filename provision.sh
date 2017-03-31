#!/usr/bin/env bash

sudo apt-get update


echo "///////////////////////////////////////////////"
echo "Installing php..."
echo "///////////////////////////////////////////////"
sudo apt-get install --assume-yes php5-cli
#apt-get install --assume-yes libapache2-mod-php5
sudo apt-get install --assume-yes php5-mcrypt php5-intl php5-pgsql php5-curl

echo "///////////////////////////////////////////////"
echo "Installing PostgreSQL..."
echo "///////////////////////////////////////////////"
export LANGUAGE=ca_ES.UTF-8
export LC_ALL=en_US.UTF-8
sudo apt-get install --assume-yes postgresql
sudo apt-get install --assume-yes postgresql-contrib
sudo -u postgres psql -U postgres -d postgres -c "alter user postgres with password 'postgres'"

echo "///////////////////////////////////////////////"
echo "Installing curl..."
echo "///////////////////////////////////////////////"
sudo apt-get install --assume-yes curl

echo "///////////////////////////////////////////////"
echo "Installing git..."
echo "///////////////////////////////////////////////"
sudo apt-get install --assume-yes git

echo "///////////////////////////////////////////////"
echo "Installing symfony installer..."
echo "///////////////////////////////////////////////"
sudo curl -LsS http://symfony.com/installer -o /usr/local/bin/symfony
sudo chmod a+x /usr/local/bin/symfony

echo "///////////////////////////////////////////////"
echo "Setting php-cli date.timezone to Madrid..."
echo "///////////////////////////////////////////////"
sudo sed -i "s/^;date.timezone =$/date.timezone = \"Europe\/Madrid\"/" /etc/php5/cli/php.ini |grep "^timezone" /etc/php5/cli/php.ini

echo "///////////////////////////////////////////////"
echo "Setting postgres to accept connections"
echo "///////////////////////////////////////////////"
sudo cp -a  /etc/postgresql/9.3/main/postgresql.conf   /etc/postgresql/9.3/main/postgresql.conf2
sudo cp -a  /etc/postgresql/9.3/main/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf2
sudo awk 'NR==59 {$0="listen_addresses='\''*'\''"} 1' /etc/postgresql/9.3/main/postgresql.conf > /etc/postgresql/9.3/main/postgresql.conf2
sudo mv /etc/postgresql/9.3/main/postgresql.conf2  /etc/postgresql/9.3/main/postgresql.conf

sudo cp /vagrant/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
sudo /etc/init.d/postgresql stop
sudo /etc/init.d/postgresql start

echo "///////////////////////////////////////////////"
echo "System settings"
echo "///////////////////////////////////////////////"
alias ll='ls -la --color'
source /vagrant/script.sh
