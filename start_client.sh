#!/bin/bash
#-----------------------------------------------
#author:lianzq                                 -
#date:2016.1-2016-5                            -
#function:call the program and the client run  -
#-----------------------------------------------

echo "Socket Server is started success"
connect()
{	
	read -p "Please enter the client IP/hostname:" client
	host=`ssh $client  hostname`
	if [ $? == 0 ];then
		echo "$client enter successful"
        	scp so_client.py $client:  >/dev/null
        	if [ $? == 0 ];then
			ssh -t $client 'python so_client.py'
		fi
	else
		echo "Host does not reach please re-enter"
	fi
}

while true; do
    read -p "Start backup file transfer...[yes|no]:" yn
    case $yn in
        y|Y|YES )connect ;;
        n|N|NO ) exit ;;
        '' ) break ;;
        * ) echo "Please answer y or n." ;;
    esac
done

