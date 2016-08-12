#!/bin/bash
#
#    set-strong-permissions.sh - Setting strong directory and file permissions
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
chown -R ${HTUSER}:${HTGROUP} $OCPATH

printf "chmod Files and Directories\n"
find ${OCPATH}/ -type f -print0 | xargs -0 chmod 0640
find ${OCPATH}/ -type d -print0 | xargs -0 chmod 0750

printf "chown directories\n"
chown -R ${ROOTUSER}:${HTGROUP} ${OCPATH}/
chown -R ${HTUSER}:${HTGROUP} ${OCPATH}/apps/
chown -R ${HTUSER}:${HTGROUP} ${OCPATH}/assets/
chown -R ${HTUSER}:${HTGROUP} ${OCPATH}/config/
chown -R ${HTUSER}:${HTGROUP} ${OCPATH}/data/
chown -R ${HTUSER}:${HTGROUP} ${OCPATH}/themes/
chown -R ${HTUSER}:${HTGROUP} ${OCPATH}/updater/

chmod +x ${OCPATH}/occ

printf "chmod/chown .htaccess\n"
if [ -f ${OCPATH}/.htaccess ]
 then
  chmod 0644 ${OCPATH}/.htaccess
  chown ${ROOTUSER}:${HTGROUP} ${OCPATH}/.htaccess
fi
if [ -f ${OCPATH}/data/.htaccess ]
 then
  chmod 0644 ${OCPATH}/data/.htaccess
  chown ${ROOTUSER}:${HTGROUP} ${OCPATH}/data/.htaccess
fi
