#! /bin/bash

#######################################
# Print Colored Text to screen.
# Arguments:
#   COLOR,Text    
# Usage:      print_colored "color" "text" 
#######################################
function print_colored() {
   case $1 in
     "green") COLOR="\033[0;32m" ;;
     "red") COLOR="\033[0;31m" ;;
     "white") COLOR="\033[0;37m" ;;
     "bwhite") COLOR="\033[1;37m" ;;
     "blue") COLOR="\033[44m" ;;
     "purple") COLOR="\033[0;35m" ;;
      "*") COLOR="\033[0m"
    esac
   echo -e "${COLOR} $2 ${NC}" 
}
#######################################
# Print welcome messages to screen.
# Arguments:
#   Non
# Usage:      welcome_message
#######################################
function welcome_message() {
    clear
    print_colored "blue" "************************************************************"
    print_colored "blue" "**                 Bash Shell Script                      **"
    print_colored "blue" "**        Replacing certain value in .yaml file           **"
    print_colored "blue" "**                                                        **"
    print_colored "blue" "**          Created by: Eng. Mahmoud Abdelaziz            **"
    print_colored "blue" "************************************************************"

}
#######################################
# Show user how to use the application.
# Arguments:
#   Non
# Usage:      how_to_use_this_script
#######################################
function how_to_use_this_script(){
    print_colored "purple" "To replace certain value access it through its sectionn and separate between sections with ."
    print_colored "purple" "Ex:"
    print_colored "white" "version: '3.9'             "
    print_colored "white" "services:                  "
    print_colored "white" "   redis:                  "
    print_colored "white" "      image: 'redis:lts'   "
    print_colored "white" "                           "
    print_colored "purple" "to change image name 'redis:lts' enter its postion is:"
    print_colored "white" ".services.redis.image"
    print_colored "purple" "then set a new value for it as you need."
}
#######################################
# parse yaml file then replace certain value.
# Arguments:
#   Non
# Usage:      parse_yaml_file
#######################################
function parse_yaml_file(){
    print_colored "white" ""
    print_colored "bwhite" "Please Enter .yaml file path:"
    print_colored "white" ""
    read script_path
    if [ -f $script_path ]
    then
        print_colored "bwhite" "The .yaml file content is:"
        print_colored "white" "$(yq -y '.' $script_path)"
        print_colored "bwhite" "Please enter the postion of the value you need to change:"
        print_colored "white" ""
        read value_position
        if [[ $(yq -y $value_position $script_path) != *"null"* ]]
        then
            print_colored "white" "the value you need to change is:"
            print_colored "white" "$(yq -y $value_position $script_path)"
            print_colored "bwhite" "Please enter the new value:"
            print_colored "white" ""
            read new_value
            yq -y -i "${value_position}=${new_value}" $script_path
            is_correct=$(echo $?)
            if [[ $is_correct -eq 0 ]]
            then
                print_colored "green" "the value set successfully."
                print_colored "white" "$(yq -y $value_position $script_path)"
            else
                print_colored "red" "there is a problem in setting your value."
            fi
        else
           print_colored "red" "there is a problem in value postion."
           parse_yaml_file
        fi
    else
        print_colored "red" "Wrong .yaml file path."
        parse_yaml_file
    fi

}