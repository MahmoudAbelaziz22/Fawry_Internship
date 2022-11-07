#! /bin/bash

#import helper_functions.sh file
source ./helper_functions.sh

# call welcome_message function
welcome_message
# aske user to enter project directory
print_colored "white" ""
print_colored "bwhite" "Please enter project directory:"
print_colored "white" ""
read PROJECT_DIR
# aske user to enter target branch
print_colored "bwhite" "Please enter your target branch:"
print_colored "white" ""
read TARGET_BRANCH
# aske user to enter remote repo url
print_colored "bwhite" "Please enter your remote repo url:"
print_colored "white" ""
read PROJECT_REMOTE_URL

#call check_branch_for_updates function and pass variables to it.
check_branch_for_updates $PROJECT_DIR $TARGET_BRANCH $PROJECT_REMOTE_URL
