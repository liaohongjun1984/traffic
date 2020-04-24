#!/bin/bash
source /etc/profile

export M2_HOME=/data/service/apache-maven-3.0.3
export M2=$M2_HOME/bin
export MAVEN_OPTS="-Xms256m -Xmx512m"
PATH=$M2:$PATH:

base_dir=/data/background
cd $base_dir/suc/src/sysop-util
svn update .

cd $base_dir/suc/src/suc-common
svn update .

cd $base_dir/suc/src/suc-impl
svn update .

cd $base_dir/suc/src/suc-web
svn update .
mvn clean package  -Dmaven.test.skip=true -Pproduct

rm -rf /data/webservers/download-4097/webapps/ROOT/suc-web.war
cp -r $base_dir/suc/src/suc-web/target/suc.war /data/webservers/download-4097/webapps/ROOT/suc-web.war

echo "build product end"