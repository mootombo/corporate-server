#!/bin/bash
#
#    post_install.sh - do post installation operations
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

# Vars
INSTALLDIR=`dirname $0`
MOODIR=`dirname $INSTALLDIR`
LIBDIR="${MOODIR}/library"
LVL2DIR=`dirname $MOODIR`
LVL1DIR=`dirname $LVL2DIR`
FILEDIR=`dirname $LVL1DIR`

# Load functions
source $LIBDIR/helper.sh

# Script
msg_note "" "starting the post_install script"

#######
# 001 #
#######
# Restart the nagios service
service nagios-nrpe-server restart
msg_success "restarting nagios-nrpe-server ... " "done!"

#######
# 002 #
#######
# Add smartctl to the sudoers list for nagios
IS_PHYSICAL=`dmesg |grep -i hypervisor`
if [ ! "$IS_PHYSICAL" ]; then
	if [ ! -f /usr/lib/mootombo/install/nagios-smartctl-sudoers ]; then
		msg_note "Adding smartctl to the list of sudoers ..." "done!"
		echo "" >> /etc/sudoers
		echo "# Nagios" >> /etc/sudoers
		echo "nagios	ALL=(root) NOPASSWD: /usr/sbin/smartctl" >> /etc/sudoers
		touch /usr/lib/mootombo/install/nagios-smartctl-sudoers
	else
		msg_success "smartctl already exist in the list of sudoers ..." "skip!"
	fi
fi

#######
# A01 #
#######
# Update the ca-certificates
#dpkg-reconfigure ca-certificates --unseen-only
update-ca-certificates

# Script
apt-get autoremove -y
msg_note "Remove automatically installed packages that are no longer used ... " "done!"
