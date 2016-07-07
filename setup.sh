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
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Load functions
source $SCRIPTDIR/library/helper.sh

# Script
echo "Mootombo Corporate Server Installation:"
echo "======================================="
#is_root && echo "You are logged in as root." || echo "You are not logged in as root."
check_root_access

# Convert library files because of Windows!?)(/§CRAP)")/%. All in /files checked by the propagation script during permission set
moo_convertff_indir "${SCRIPTDIR}/library"

# Start the install script
#timer 10
bash $SCRIPTDIR/library/install.sh
