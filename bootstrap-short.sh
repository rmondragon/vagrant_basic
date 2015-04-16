#!/usr/bin/env bash

sudo apt-get update -y
sudo apt-get dist-upgrade -y

#apache
sudo apt-get install -y apache2 apache2-utils
sudo service apache2 restart

#copy virtualhost
sudo cp /vagrant/config/vhosts/* /etc/apache2/sites-available/
sudo a2ensite test.dev.conf
sudo a2ensite ui-bproc.dev.conf
sudo a2ensite delivery.dev.conf
service apache2 reload
