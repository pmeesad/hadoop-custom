#!/bin/bash

# Set correct permissions for Hadoop directories
sudo chown -R hadoop:hadoop $HADOOP_HOME
sudo chmod -R 755 $HADOOP_HOME

# Format HDFS if not already formatted
if [ ! -d $HADOOP_HOME/data/namenode/current ]; then
  $HADOOP_HOME/bin/hdfs namenode -format
fi

# Start SSH service
sudo service ssh start

# Start Hadoop services
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh

# Print the jps output to verify Hadoop processes
jps

# Keep container running
tail -f /dev/null
