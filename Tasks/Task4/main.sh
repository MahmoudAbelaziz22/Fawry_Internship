#! /bin/bash

source ./helper_functions.sh

USERNAME=$1

welcome_message

OS=$(echo $(egrep '^(ID)=' /etc/os-release) |cut -f2 -d=)

check_distrbution "$OS" "$USERNAME"
