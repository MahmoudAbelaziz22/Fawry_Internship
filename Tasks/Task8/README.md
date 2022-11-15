#Task8
write bash script that read a log file and exract data from it then pass it to text file.
for example: I wrote script to trace sudo usage in ubuntu based system.

## How to Run the Script:
1- clone github repo to your local system:
```
git clone https://github.com/MahmoudAbelaziz22/Fawry_internship.git

```
2- change your current directory to task8 directory:
```
cd ./Fawry internship/Tasks/Task8
```
3- give excution permission to notify_logs.sh and helper_functions.sh files:

```
 chmod +x notify_logs.sh helper_functions.sh 
```
4- run notify_logs.sh in the background:
```
./notify_logs.sh &
```
5- check if script is running in the background:
```
jobs
```
then try to use sudo in your terminal and check sudo.access.txt file to see the changes.

6- to kill backgroung running script use kill %bg_proccess_number :
```
kill %1
```