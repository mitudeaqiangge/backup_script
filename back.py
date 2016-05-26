#!/usr/bin/env python
#-*- coding:utf-8 -*-
#-----------------------------------------
#author:lianzq                           -
#date:2016.1-2016-5                      -
#function:the backup of the main program -
#-----------------------------------------
import os
import SocketServer
def display():
	caidan = '''
        * * * * * * * * * * * * * * * * * * * * *
        *             网络备份系统              *
        *                                       *
        *       请输入备份方式                  *
        *       1 本地备份                      *
        *       2 异地文件传输备份              *
	*       3 退出程序                      *
        *                                       *  
        * * * * * * * * * * * * * * * * * * * * * '''

	print caidan
display()
while True:
#	display()
	num1=raw_input("选择备份方式（1/2/3）：")
	if num1 == "1" :
		os.system("sh bendi.sh")
	elif num1 == "2" :
		os.system("gnome-terminal -x  ./so_server.py && sh start_client.sh")
	elif num1 == "3" :
		print "Program exit successfully"
		break
	else :
		print"输入错误请重新输入:"

