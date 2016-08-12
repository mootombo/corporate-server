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
# https://doc.owncloud.org/server/9.0/admin_manual/installation/source_installation.html#enabling-ssl

# Vars
LIBDIR="/usr/lib/mootombo/library"
INSTALLDIR="/usr/lib/mootombo-owncloud"

# Load functions
source $LIBDIR/helper.sh
source $INSTALLDIR/config.sh

# Script
msg_note "" "starting the install script"

########################
# Install dependencies #
########################
check_installed clamav
check_installed zip
check_installed php-gettext
check_installed php7.0-zip
check_installed php7.0-ldap
check_installed php7.0-xml
check_installed php7.0-curl
check_installed phpmyadmin
#check_installed php7.0-
#check_installed php7.0-
#check_installed php7.0-
check_installed nfs-common

# Starting the propagation script
timer 5
bash $INSTALLDIR/postinstall.sh
