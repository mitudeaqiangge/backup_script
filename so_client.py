#!/usr/bin/python 
#coding:utf-8
#-----------------------------------------
#author:lianzq                           -
#date:2016.1-2016-5                      -
#function:the socket client main program -
#-----------------------------------------
 
import socket 
import sys 
import time
import os
display='''
	* * * * * * * * * * * * * * * *
	*    start client program     *
        *    上传：put  filename      *
	*    下载：get  filename      *
        *    退出：exit 0             *
	* * * * * * * * * * * * * * * *
	'''
print display
ip = '192.168.1.1'
port = 60000
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM) 
def recvfile(filename): 
    print "server ready, now client rece file~~"
    f = open(filename, 'wb') 
    while True: 
        data = s.recv(4096) 
        if data == 'EOF': 
            print "recv file success!"
            break
        f.write(data) 
    f.close() 
def sendfile(filename): 
    print "server ready, now client sending file~~"
    f = open(filename, 'rb') 
    while True: 
        data = f.read(4096) 
        if not data: 
            break
        s.sendall(data) 
    f.close() 
    time.sleep(1) 
    s.sendall('EOF') 
    print "send file success!"
                                 
def confirm(s, client_command): 
    s.send(client_command) 
    data = s.recv(4096) 
    if data == 'ready': 
        return True
                                 
try: 
    s.connect((ip,port)) 
    while 1: 
        client_command = raw_input("put/get/(exit 0)>>") 
        if not client_command: 
            continue
                                     
        action, filename = client_command.split() 
        if action == 'put': 
            if confirm(s, client_command): 
                sendfile(filename) 
            else: 
                print "server get error!"
        elif action == 'get': 
            if confirm(s, client_command): 
                recvfile(filename) 
            else: 
                print "server get error!"
        elif action == 'exit': 
		break
        else: 
            print "command error!"
except socket.error,e: 
    print "get error as",e 
finally: 
    s.close() 
