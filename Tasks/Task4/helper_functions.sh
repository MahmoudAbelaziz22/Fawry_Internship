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
    print_colored "blue" "**  Install Docker using apt-get(Ubuntu) or yum(Centos)   **"
    print_colored "blue" "**                                                        **"
    print_colored "blue" "**          Created by: Eng. Mahmoud Abdelaziz            **"
    print_colored "blue" "************************************************************"

}
##################################################
# installing docker using apt-get package manager.
# Arguments:
#   Non
# Usage:      isntall_docker_with_apt
##################################################
function install_docker_with_apt(){
    print_colored "white" ""
    docker -v
    is_exist=$(echo $?)
    if [[ $is_exist=0 ]]
    then
        print_colored "green" "Docker engine already exist."
        print_colored "white" ""
        docker-compose --version
        compose_exist=$(echo $?)
        if [[ $compose_exist=0 ]]
        then
          print_colored "green" "Docker compose already exist."
          print_colored "white" ""
        else
          sudo apt-get install docker-compose-plugin
        fi
    else
        sudo apt-get update
        sudo apt-get install \
            ca-certificates \
            curl \
            gnupg \
            lsb-release
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
        sudo docker --version

        sudo apt-get install docker-compose-plugin
    fi
}

##################################################
# installing docker using yum package manager.
# Arguments:
#   Non
# Usage:      isntall_docker_with_yum
##################################################
function install_docker_with_yum(){
    print_colored "white" ""
    docker -v
    is_exist=$(echo $?)
    if [[ $is_exist=0 ]]
    then
       print_colored "green" "Docker engine already exist."
       print_colored "white" ""
       docker-compose --version
       compose_exist=$(echo $?)
       if [[ $compose_exist=0 ]]
       then
          print_colored "green" "Docker compose already exist."
          print_colored "white" ""
       else
          sudo yum install docker-compose-plugin
        fi
    else
       sudo yum install -y yum-utils
       sudo yum-config-manager \
       --add-repo \
       https://download.docker.com/linux/centos/docker-ce.repo
       sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
       sudo systemctl start docker

       sudo docker --version

       sudo yum install docker-compose-plugin
    
    fi

}
##################################################
# configure and run docker-compose to start wordpress.
# Arguments:
#  USERNAME
# Usage:      configure_wordpress USERNAME
##################################################
function configure_wordpress() {
    USERNAME=$1
    cd "./Fawry_internship/Labs/dockerWordpress/"
    print_colored "green" "Copying data to local volume..."
    print_colored "white" ""
    sudo docker-compose up -d
    sudo docker-compose down
    sudo rm -r /var/lib/docker/volumes/dockerwordpress_wp-data/_data
    sudo cp -r ./dockerwordpress_wp-data/_data/ /var/lib/docker/volumes/dockerwordpress_wp-data/
    print_colored "green" "Starting your app..."
    print_colored "white" ""
    sudo docker-compose up -d
    sudo -u $USERNAME bash -c 'google-chrome http://localhost:8888'
    print_colored "green" "Doneeeeeeee!."
}
##################################################
# run configure_wordpress function or clone repo and then run.
# Arguments:
#   USERNAME
# Usage:      run_wordpress USERNAME
##################################################
function run_wordpress() {
    USERNAME=$1
    print_colored "green" "Wordpress set up..."
    print_colored "white" ""
    if [[ -d "Fawry_internship" ]]
    then
        #call configure_wordpress function
        configure_wordpress "$USERNAME"
    else
        print_colored "green" "Cloning git repo..."
        print_colored "white" ""
        git clone https://github.com/MahmoudAbelaziz22/Fawry_internship.git
        #call configure_wordpress function
        configure_wordpress "$USERNAME"
    fi

}
##################################################
# installing docker using apt-get package manager.
# Arguments:
#   OS_Dist and USERNAME
# Usage:      check_distrbution OS_Dist USERNAME
##################################################
check_distrbution() {
    OS_Dist=$1
    USERNAME=$2

    if [[ $OS_Dist="ubuntu" || $OS_Dist="debian" ]]
    then
        #call install_docker_with_apt function
        install_docker_with_apt
        #call run_wordpress function
        run_wordpress "$USERNAME"


    elif [[ $OS_Dist="centos" || $OS_Dist="rhel" ]]
    then
        #call install_docker_with_yum function
        install_docker_with_yum
        #call run_wordpress function
        run_wordpress "$USERNAME"
    else
       print_colored "red" "Can not identify Linux distrbution."
    fi
}