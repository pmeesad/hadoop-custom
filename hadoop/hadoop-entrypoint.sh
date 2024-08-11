#!/bin/bash

# Automatically respond "yes" to the HDFS format prompt
yes | hdfs namenode -format

# Start Hadoop services
start-dfs.sh
start-yarn.sh

# Keep the container running
tail -f $HADOOP_HOME/logs/*.log
