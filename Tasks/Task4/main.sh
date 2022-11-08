#! /bin/bash

source ./helper-functions.sh

welcome_message

OS=$(echo $(egrep '^(ID)=' /etc/os-release) |cut -f2 -d=)

check_distrbution "$OS"
