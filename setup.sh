#!/bin/bash
#
#    setup.sh - copy the file stuff into the system
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
#CURRENTDIRFROMWHEREYOUSTART=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SCRIPTDIR="$(dirname $0)"

# Load functions
source $SCRIPTDIR/files/usr/lib/mootombo/library/helper.sh

# Script
echo "Mootombo Corporate Server Installation:"
echo "======================================="
#is_root && echo "You are logged in as root." || echo "You are not logged in as root."
check_root_access

# Convert library files because of Windows!?)(/§CRAP)")/%. All in /files checked by the propagation script during permission set
moo_convertff_indir "${SCRIPTDIR}/files/usr/lib/mootombo/library"
moo_convertff_indir "${SCRIPTDIR}/files/usr/lib/mootombo/install"

#############################
# Install available updates #
#############################
msg_note "" "Check for and install updates and upgrades"
apt-get update && apt-get upgrade && apt-get dist-upgrade && apt-get autoremove

# Start the install script
timer 5
bash $SCRIPTDIR/files/usr/lib/mootombo/install/install.sh
