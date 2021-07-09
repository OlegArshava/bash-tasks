#!/bin/bash

#check run script as root

if [ `whoami` != 'root' ]; then
     echo "You must be root"
     exit
fi

#check environment variable and set 

if  [ ! -n "$DB_NAME" ] && [ ! -n "$DB_USER" ] && [ ! -n "$DB_PASS" ]; then

    read -p "Enter name db:" db_name
    echo "export DB_NAME='$db_name'" >> /etc/environment

    read -p "Enter db user:" db_user
    echo "export DB_USER='$db_user'" >> /etc/environment

    read -s -p "Enter passwdord db:" db_pass
    echo "export DB_PASS='$db_pass'" >> /etc/environment
    source /etc/environment
fi


#generating file name

curdateime=`date +%F_%H:%M`
filenamePrefix=$DB_NAME"_"
filename=$filenamePrefix$curdateime".sql"


#check run mysql service


statusService=`systemctl show -p ActiveState --value mysql`

if [ $statusService == "active" ]
then
    printf "${COLOR_GREEN}Service is running\n${NO_COLOR}" 
    mysqldump --no-tablespaces --user="$DB_USER" --password="$DB_PASS" "$DB_NAME" > "$filename"
    printf "${COLOR_GREEN}Backup is done\n${NO_COLOR}" 
else
    printf "${COLOR_RED}MySql service not running\n${NO_COLOR}"
exit
fi

