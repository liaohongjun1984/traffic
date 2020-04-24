#!/bin/bash
source /etc/profile

cd /data/temp
rm -rf suc-web.war

wget http://120.132.37.251:4097/suc-web.war
if [ $? -eq 0 ];then
 	 echo "wget war package success!"
else
  	echo "wget war package fail!"
  	exit $?
fi

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

mkdir -p /data/webapps/suc/
rm -rf /data/webapps/suc/*
mv /data/temp/suc-web.war /data/webapps/suc/ROOT.war

sh /data/webservers/suc-40001/bin/catalina.sh start
if [ $? -eq 0 ];then
 	 echo "start process success!"
else
  	echo "start process fail!"
  	exit $?
fi

echo "build product end"
tail -f /data/webservers/suc-40001/logs/catalina.out