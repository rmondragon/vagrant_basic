#!/usr/bin/env bash

sudo apt-get update
#essentials
sudo apt-get install -y build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip git curl python-software-properties python g++ make
#additionals
sudo apt-get install -y vim
sudo apt-get install -y imagemagick
sudo apt-get install -y git
sudo apt-get install curl
#mysql
sudo apt-get install -y mysql-server mysql-client
sudo service mysql restart
sudo mysqladmin -u root password 'password'
sudo mysqladmin -u root -ppassword reload

#adding vagrant user
QUERY01="CREATE USER 'vagrant'@'%' IDENTIFIED BY 'password';"
QUERY02="GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%' WITH GRANT OPTION;"
QUERY03="FLUSH PRIVILEGES;"
QUERY04="${QUERY01}${QUERY02}${QUERY03}"
sudo /usr/bin/mysql -u root -ppassword -e "$QUERY04"
sudo service mysql restart

#apache
sudo apt-get install -y apache2 apache2-utils libapache2-mod-auth-mysql
sudo service apache2 restart
#php
apt-get install php5 libapache2-mod-php5
sudo service apache2 restart
#php modules
sudo apt-get install -y php5-dev php5-mysql php-pear php5-gd php5-mcrypt php5-curl php5-imagick php5-memcached memcached php5-sqlite php5-tidy php5-xmlrpc php5-xsl
sudo service apache2 restart
#xcache
sudo apt-get install -y php5-xcache
sudo service apache2 restart
#xdebug
sudo apt-get install -y php5-xdebug
sudo service apache2 restart

# Added for xdebug
#zend_extension="/usr/lib/php5/20121212/xdebug.so"
#xdebug.remote_enable=1
#xdebug.remote_handler=dbgp
#xdebug.remote_mode=req
#xdebug.remote_host=127.0.0.1
#xdebug.remote_port=9000
#xdebug.max_nesting_level=300



#npm nodejs bower composer
sudo curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer
sudo apt-get install -y nodejs npm
sudo npm install -g bower
sudo npm install -g uglify-js
sudo npm install -g uglifycss
sudo npm install -g grunt-cli
sudo npm install -g zombie

echo "PROVISIONED!!!"
