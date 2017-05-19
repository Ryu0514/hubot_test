#!/bin/sh
username = 'koishi0910'
hostname = '10.213.201.2'
passwdfile = 'passwd_toscana.dat'
portnum = '22'
command = $hostname:$portnum" /ssh /auth=password /user="$username

#ssh $command
echo "execute shell script"
