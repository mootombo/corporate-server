#!/bin/bash

# Standard install script for profile: Webserver
# Includes: Webmin and various PHP packages

# Add Webmin repository and install (http://www.webmin.com/deb.html)
cp /etc/apt/sources.list /etc/apt/sources.list.bak
echo "deb http://download.webmin.com/download/repository sarge contrib" | sudo tee -a /etc/apt/sources.list
cd ~
wget http://www.webmin.com/jcameron-key.asc
apt-key add jcameron-key.asc
apt-get update && apt-get upgrade -y && apt-get install -y apt-transport-https && apt-get install -y webmin

#############################################################################

# PHP packages nachinstallieren
apt-get install -y php7.0-mbstring php7.0-zip php7.0-curl php7.0-gd php7.0-ldap
service apache2 restart


#############################################################################

# Installing clamav antivirus
apt-get install -y clamav clamav-daemon

#############################################################################

# Install Nextcloud
cd /var/www/html
wget https://download.nextcloud.com/server/installer/setup-nextcloud.php
rm index.html
chmod -R 777 /var/www/html
mkdir -p /var/www/data
chmod 770 /var/www/data
chown www-data:www-data /var/www/data






#############################################################################

# Documentation
cat > /root/webserver-doc.txt <<EOF
Documentation: Webserver installation
#####################################

Webmin:
#######
URL of your Webmin installation: https://${HOSTNAME}:10000

To login, use your username and password you have set during ubuntu installation (user with sudo privileges)

EOF
