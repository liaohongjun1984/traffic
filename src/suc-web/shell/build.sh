#!/bin/bash
source /etc/profile

export M2_HOME=/data/apache-maven-3.0.3
export M2=$M2_HOME/bin
export MAVEN_OPTS="-Xms256m -Xmx512m"
PATH=$M2:$PATH:

base_dir=$(cd `dirname $0`; pwd)

cd $base_dir/../../suc-common
svn update .
mvn install -Dmaven.test.skip=true

cd $base_dir/../../suc-impl
svn update .
mvn install -Dmaven.test.skip=true

cd $base_dir/../../suc-web
svn update .
mvn clean package  -Dmaven.test.skip=true -Ptest,test-properties

kill -9 `netstat -nlp | grep 1091 | awk '{print $7}'|awk -F/ '{print $1}'`

mkdir -p /data/webapps/traffic/
rm -rf /data/webapps/traffic/*
cp -r $base_dir/../target/traffic.war /data/webapps/traffic/ROOT.war

rm -rf /data/webservers/1091-traffic/logs/catalina.out
sh /data/webservers/1091-traffic/bin/catalina.sh start
tail -f /data/webservers/1091-traffic/logs/catalina.out