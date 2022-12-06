#Task9:

write bash script do that:

   1- pull git repo
   
   2- use Dockerfile in cloned repo to build a docker image with a tage of today date

   3- push the image to remote docker registry.
## How to Run the Script:
1- clone github repo to your local system:
```
git clone https://github.com/MahmoudAbelaziz22/Fawry_internship.git

```
2- change your current directory to task9 directory:
```
cd ./Fawry internship/Tasks/Task9
```
3- give excution permission to notify_logs.sh and helper_functions.sh files:

```
 chmod +x docker_build_and_push.sh
```
4- run docker_build_and_push.sh :
```
./docker_build_and_push.sh laravel "https://ecommerceBIS:glpat-dvLRZp4ey2_NHNgHX1tc@gitlab.com/mahmoudabdelaziz/ecommerceBIS.git"
```