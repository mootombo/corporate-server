#!/bin/bash
#
#    install.sh - check and install apps before propagation files
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
LIBDIR=`dirname $0`
#SCRIPTDIR2=`pwd -P`
MAINDIR=`dirname $LIBDIR`
FILEDIR="${MAINDIR}/files"


# Load functions
source $LIBDIR/helper.sh

# Script
msg_note "" "starting the install script"

#######
# 001 #
#######
# Install the nagios server for remote monitoring within the UMC
check_installed nagios-nrpe-server


# Starting the propagation script
timer 10
bash $LIBDIR/propagation.sh
