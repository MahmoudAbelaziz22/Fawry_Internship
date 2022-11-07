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
    print_colored "blue" "**             Bash Shell Scripting Project               **"
    print_colored "blue" "**        Check any branch for any new updates on it      **"
    print_colored "blue" "**                                                        **"
    print_colored "blue" "**          Created by: Eng. Mahmoud Abdelaziz            **"
    print_colored "blue" "************************************************************"

}
#######################################
# Check branch for any update on it.
# Arguments:
#   PROJECT_DIR , TARGET_BRANCH and PROJECT_REMOTE_URL
# Usage: check_branch_for_updates $PROJECT_DIR $TARGET_BRANCH $PROJECT_REMOTE_URL
#######################################
function check_branch_for_updates() {
    
    PROJECT_DIR=$1
    TARGET_BRANCH=$2
    PROJECT_REMOTE_URL=$3
    
    if [[ -d $PROJECT_DIR ]]
    then
        cd $PROJECT_DIR  
        git checkout $TARGET_BRANCH
        is_exist=$(echo $?)
        if [[ $is_exist -eq 0 ]]
        then
            git rev-list HEAD > branch_commit.txt #List commits
            remote_branch_sha=$(git ls-remote $PROJECT_REMOTE_URL HEAD | awk '{ print $1}')
            if grep -Fxq "$remote_branch_sha"  ./branch_commit.txt
            then
                print_colored "green" "Your local repo already up to date."
            else
                print_colored "red" "Your local repo is not up to date, please pull the new change on remote repo."
            fi
        else
            print_colored "red" "Wrong branch name."
        fi

    else
        print_colored "red" "this directory does not exist, please clone the project to your local system then pass its dir path."
    fi        
}