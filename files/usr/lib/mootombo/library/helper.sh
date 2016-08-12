#!/bin/bash
is_root(){
   [ $(id -u) -eq 0 ] && return $TRUE || return $FALSE
}

# Function to echo out a coloured message (Green)
# $1	string	pre text
# $2	string	coloured text
# $3	string	post text
function msg_success()
{
	echo
	echo -e "${1}\e[38;5;82m${2}\e[0m${3}"
}

# Function to echo out a coloured message (Yellow)
# $1	string	pre text
# $2	string	coloured text
# $3	string	post text
function msg_warning()
{
	echo
	echo -e "${1}\e[38;5;226m${2}\e[0m${3}"
}

# Function to echo out a coloured message (Cyan)
# $1	string	pre text
# $2	string	coloured text
# $3	string	post text
function msg_note()
{
	echo
	echo -e "${1}\e[38;5;87m${2}\e[0m${3}"
}

# Function to echo out a coloured message (Red)
# $1	string	pre text
# $2	string	coloured text
# $3	string	post text
function msg_alert()
{
	echo
	echo -e "${1}\e[38;5;196m${2}\e[0m${3}"
}

# Function to echo out a coloured message (White)
# $1	string	coloured text
function msg_pure()
{
	echo
	echo -e "\e[38;5;255m${1}\e[0m"
}

# Function to echo out a coloured message (Pink)
# $1	string	pre text
# $2	string	coloured text
# $3	string	post text
function msg_user()
{
	echo
	echo -e "${1}\e[38;5;165m${2}\e[0m${3}"
}

# Function to echo out a coloured message (Orange)
# $1	string	pre text
# $2	string	coloured text
# $3	string	post text
function msg_danger()
{
	echo
	echo -e "${1}\e[38;5;202m${2}\e[0m${3}"
}

# Function to echo out a coloured message (Yellow)
# $1	string	pre text
# $2	string	coloured text
# $3	string	post text
function msg_working()
{
	echo -e "${1}\e[38;5;226m${2}\e[0m${3}"
}

# Function to echo out a coloured message (Gold)
# $1	string	coloured text
function msg_script()
{
	if [ "${1}" != "" ]; then
		echo
		echo -e "[SCRIPT]: \e[38;5;180m${1}\e[0m"
	else
		echo
		echo -e "[SCRIPT]: \e[38;5;180mMay the Force be with you, my young Padawan!\e[0m"
	fi
}

function check_root_access()
{
	msg_user "Currently performing as: " "$USER"

	if [ ! -z "$SUDO_USER" ]; then
		msg_success "Root access is: " "GRANTED"
	else
		msg_alert "Root access is: " "INVALID"
		msg_danger "Use " "sudo" " in front of the command to get root access or log in as root - sudo su"
		exit 1;
	fi
}

function timer()
{
	msg_pure "Please wait or hit [Control] + C to abort!"
	msg_alert "" "Note: If you cancel setup after the timer has been stopped,\ninstallation may be corrupt!"
	sek="$1"
	while [ "$sek" -ge 1 ]
	do
		echo
		echo -n " => Setup starts in $sek seconds..."
		echo -n $'\r'
		sleep 1
		sek=$[$sek-1]
	done
	msg_script
}

function check_installed()
{
	if dpkg-query -s $1 2>/dev/null|grep -q installed; then
		msg_note "$1 ..." "already installed"
	else
		msg_warning "Note: " "Package not found. We'll try to install it now!"
		apt-get install -y $1
		if dpkg-query -s $1 2>/dev/null|grep -q installed; then
			msg_success "$1 ..." "installed"
		else
			msg_warning "ALERT: " "The package $1 could not be installed! Maybe there are possible conflicts during installation."
			msg_warning "" "Please go ahead and check this!"
		fi
	fi
}


#############################################################################
## Files and Directories                                                   ##
#############################################################################

#
#
#
#
#
function moo_copy()
{
	msg_success "create WSCC directory if not exists ..." "done!"
	mkdir -p $1
	msg_pure "copy files to destination ..."
	cp -R * $1
	msg_success "copy files to destination ..." "done!"
}

#
#
#
#
# Convert fileformat (dos>unix)
#
function moo_convertff()
{
	check_installed dos2unix
	msg_pure "converting files ..."
	for item in $1/*; do
	    	if [[ -d $item ]]; then
			cd "$item"
			dos2unix -k *
		else
			dos2unix -k *
		fi
	done
	msg_success "converting files ..." "done!"
}

#
#
#
#
# Convert fileformat (dos>unix) for all files only in the given directory
#
function moo_convertff_indir()
{
	check_installed dos2unix
	msg_pure "try to convert all files in $1 ..."
	dos2unix -k $1/*
	msg_success "converting files ..." "done!"
}

function moo_clean_this()
{
	if [ "$1" != "" ]; then
		rm -R $1/files
		rm -R $1/library
		rm -R $1/remaster
		rm -R $1/univention
		rm -R $1/wscc-setup.sh
	fi
}

function killself()
{
	rm -R /tmp/corporate-*
}
