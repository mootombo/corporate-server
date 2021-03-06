#!/bin/bash
#
#    propagation.sh - copy the file stuff into the system
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
msg_note "" "starting the propagation script"

# Copy files to
msg_script "Copy files into the filesystem ..."
rsync -rv $FILEDIR/* /

msg_script "Set file permissions ..."
# read file names from library/propagation.txt one by one and copy then into its destination
# also change the file permissions; (NOTE THAT $file already have a prior slash/)
while read STRING ; do
	FILE="${STRING:4}"
	PERM="${STRING:0:3}"

	# Because Windows
	dos2unix -q $FILE

	#Use text instead of the -v (verbose option for a cleaner look
	msg_working "Try to convert to unix fileformat and set file permission for ${FILE} (${PERM}) ... " "done!"
	#remove cp args due to replacement with rsync
	#cp -R "${FILEDIR}${FILE}" "$FILE"
	chmod -R $STRING
done < $INSTALLDIR/propagation.txt
msg_success "Copy files into the filesystem and set permissions ..." "done!"

# Starting the post_install script
timer 5
bash $INSTALLDIR/post_install.sh