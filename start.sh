#!/bin/bash

# start ssh
service ssh start
ssh-keyscan localhost > /root/.ssh/known_hosts
ssh-keyscan 0.0.0.0 >> /root/.ssh/known_hosts

# start hadoop
$HADOOP_HOME/sbin/start-all.sh

$HADOOP_HOME/bin/hdfs dfs -mkdir /tmp
$HADOOP_HOME/bin/hdfs dfs -chmod 1777 /tmp
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/hive/warehouse
$HADOOP_HOME/bin/hdfs dfs -chown -R hive:hive /user/hive
$HADOOP_HOME/bin/hdfs dfs -chmod -R 775 /user/hive
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/hdpu
$HADOOP_HOME/bin/hdfs dfs -chown -R hdpu:hdfs /user/hdpu
$HADOOP_HOME/bin/hdfs dfs -chmod 755 /user/hdpu

# start mysql and create databases/users for hue and hive
chown -R mysql:mysql /var/lib/mysql
usermod -d /var/lib/mysql/ mysql
service mysql start

echo """
  CREATE USER 'hue'@'localhost' IDENTIFIED BY 'hue';
  GRANT ALL PRIVILEGES on *.* to 'hue'@'localhost' WITH GRANT OPTION;
  GRANT ALL on hue.* to 'hue'@'localhost' IDENTIFIED BY 'hue';
  FLUSH PRIVILEGES;
  CREATE DATABASE hue;

  CREATE USER 'hive'@'localhost' IDENTIFIED BY 'hive';
  GRANT ALL PRIVILEGES on *.* to 'hive'@'localhost' WITH GRANT OPTION;
  GRANT ALL on hive.* to 'hive'@'localhost' IDENTIFIED BY 'hive';
  FLUSH PRIVILEGES;
  CREATE DATABASE hive;
""" | mysql --user=root --password=$MYSQL_PWD

# start hive
$HIVE_HOME/bin/schematool -initSchema -dbType mysql
$HIVE_HOME/bin/hive --service hiveserver2 > /dev/null 2>&1 &
$HIVE_HOME/bin/hive --service metastore > /dev/null 2>&1 &

# start hue
$HUE_HOME/build/env/bin/hue syncdb --noinput
$HUE_HOME/build/env/bin/hue migrate
$HUE_HOME/build/env/bin/hue runserver 0.0.0.0:8888 > /dev/null 2>&1 &

# persist the container
tail -f /dev/null
