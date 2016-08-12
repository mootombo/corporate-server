#!/bin/bash
#
#    set-upgrade-permissions.sh - Sets permissions of the owncloud instance for updating
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

# Vars
LIBDIR="/usr/lib/mootombo/library"
INSTALLDIR="/usr/lib/mootombo-owncloud"

# Load functions
source $LIBDIR/helper.sh
source $INSTALLDIR/config.sh

########################################
# Setting strong directory permissions #
########################################
chown -R ${htuser}:${htgroup} ${ocpath}