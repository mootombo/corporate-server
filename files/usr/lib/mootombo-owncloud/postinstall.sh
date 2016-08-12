#!/bin/bash
#
#    install.sh - prepare and install owncloud server
#    Copyright (C) 2009-2016 devXive - research and development
#
#    Authors: Lahmizzar Valeryon
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# https://doc.owncloud.org/server/9.0/admin_manual/installation/installation_wizard.html#setting-strong-directory-permissions
# https://doc.owncloud.org/server/9.0/admin_manual/installation/source_installation.html#ubuntu-installation-label
# https://doc.owncloud.org/server/9.0/admin_manual/configuration_server/harden_server.html#use-https-label

# Vars
LIBDIR="/usr/lib/mootombo/library"
INSTALLDIR="/usr/lib/mootombo-owncloud"

# Load functions
source $LIBDIR/helper.sh
source $INSTALLDIR/config.sh

####################
# Extract owncloud #
####################
printf "Extract OC files\n"
tar -C /var/www -xvjf $INSTALLDIR/source/$OCFILE

############################
# Copy files and link them #
############################
printf "Copy apache oc config files\n"
cp $INSTALLDIR/apache2/*.conf /etc/apache2/sites-available/

#################################
# Apache conf files and modules #
#################################
a2dissite 000-default	# Disable default
a2dissite default-ssl	# Disable default
a2ensite owncloud	# Enable OC site
a2enmod ssl		# Enable ssl mod
a2ensite owncloud-ssl	# Enable OC-ssl site
a2enmod rewrite		# Enable rewrite mod
a2enmod headers		# Enable headers mod
a2enmod env		# Enable env mod
a2enmod dir		# Enable dir mod
a2enmod mime		# Enable mime mod
service apache2 restart

printf "Creating possible missing Directories\n"
mkdir -p $OCDATA
mkdir -p $OCPATH/data
mkdir -p $OCPATH/assets
mkdir -p $OCPATH/updater

# Starting the strong permissions script
timer 5
bash $INSTALLDIR/set-strong-permissions.sh
