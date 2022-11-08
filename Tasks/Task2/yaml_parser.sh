#! /bin/bash

#install yq python lib if not exist
yq --version
is_yq_installed=$(echo $?)
if [[ $is_yq_installed -ne 0 ]]
then
   pip install yq
fi
#install jq python lib if not exist
jq --version
is_jq_installed=$(echo $?)
if [[ $is_jq_installed -ne 0 ]]
then
   pip install jq
fi

#import helper-functions.sh file 
source ./helper_functions.sh

#call welcome_message function 
welcome_message

#call how_to_use_this_script function 
how_to_use_this_script

#call parse_yaml_file function 
parse_yaml_file