#!/usr/bin/env bash

sudo apt-get update -y
sudo apt-get dist-upgrade -y

#essentials
sudo apt-get install -y build-essential libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip git curl python-software-properties python g++ make vim imagemagick git

#mysql
debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'
sudo apt-get update -y
sudo apt-get install -y mysql-server mysql-client

#apache
sudo apt-get install -y apache2 apache2-utils libapache2-mod-auth-mysql
sudo service apache2 restart

#php
apt-get install -y php5 php5-dev libapache2-mod-php5 php5-mysql
sudo service apache2 restart

#php modules
sudo apt-get install -y php-pear php5-gd php5-mcrypt php5-curl php5-imagick php5-memcached memcached php5-sqlite php5-tidy php5-xmlrpc php5-xsl
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

sudo apache2ctl stop
sudo php5enmod curl
sudo php5enmod memcached
sudo php5enmod mysql
sudo php5enmod imagick
sudo php5enmod mcrypt
sudo php5enmod tidy
sudo apache2ctl start

#npm nodejs bower composer
sudo curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer
sudo apt-get install -y nodejs npm
#sudo npm install -g bower
#sudo npm install -g uglify-js
#sudo npm install -g uglifycss
#sudo npm install -g grunt-cli
#sudo npm install -g zombie


#adding vagrant user
QUERY01="CREATE USER 'vagrant'@'%' IDENTIFIED BY 'password';"
QUERY02="GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%' WITH GRANT OPTION;"
QUERY03="FLUSH PRIVILEGES;"
QUERY04="${QUERY01}${QUERY02}${QUERY03}"
sudo /usr/bin/mysql -u root -pvagrant -e "$QUERY04"
sudo service mysql restart


#copy virtualhost
sudo cp /vagrant/config/vhosts/* /etc/apache2/sites-available/
sudo a2ensite test.dev.conf
sudo a2ensite ui-bproc.dev.conf
sudo a2ensite delivery.dev.conf
service apache2 reload
