#!/bin/bash
source /etc/profile

pid=`netstat -nlp | grep 40001 | awk '{print $7}'|awk -F/ '{print $1}'`
if [ "$pid" ]; then
	kill -9 `netstat -nlp | grep 40001 | awk '{print $7}'|awk -F/ '{print $1}'`
	if [ $? -eq 0 ];then
	 	 echo "kill process success!"
	else
	  	echo "kill process fail!"
	  	exit $?
	fi
fi

sh /data/webservers/suc-40001/bin/catalina.sh start
if [ $? -eq 0 ];then
 	 echo "start process success!"
else
  	echo "start process fail!"
  	exit $?
fi

tail -f /data/webservers/suc-40001/logs/catalina.out