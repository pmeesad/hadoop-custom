# Use the existing image as the base
FROM pmeesad/hadoop:3.4.0

# Set environment variables
ENV HADOOP_VERSION=3.4.0 \
    SQOOP_VERSION=1.4.7 \
    HADOOP_HOME=/home/hadoop/hadoop \
    SQOOP_HOME=/home/hadoop/sqoop \
    HADOOP_CONF_DIR=/home/hadoop/hadoop/etc/hadoop \
    HBASE_HOME= \
    HCAT_HOME= \
    ACCUMULO_HOME= \
    ZOOKEEPER_HOME= \
    PATH=$PATH:/home/hadoop/sqoop/bin

USER root

# Install sudo to allow the 'hadoop' user to start ssh service
RUN apt-get update && apt-get install -y sudo

# Download and extract Sqoop using wget
RUN wget -O /tmp/sqoop-${SQOOP_VERSION}.bin__hadoop-2.6.0.tar.gz https://archive.apache.org/dist/sqoop/${SQOOP_VERSION}/sqoop-${SQOOP_VERSION}.bin__hadoop-2.6.0.tar.gz \
    && tar -xzf /tmp/sqoop-${SQOOP_VERSION}.bin__hadoop-2.6.0.tar.gz -C /opt/ \
    && mv /opt/sqoop-${SQOOP_VERSION}.bin__hadoop-2.6.0 $SQOOP_HOME \
    && rm /tmp/sqoop-${SQOOP_VERSION}.bin__hadoop-2.6.0.tar.gz

# Copy configuration files
COPY core-site.xml hdfs-site.xml yarn-site.xml mapred-site.xml $HADOOP_CONF_DIR/
COPY sqoop-site.xml $SQOOP_HOME/conf/
COPY log4j.properties $HADOOP_CONF_DIR/
# Copy the entrypoint script to the container
COPY hadoop-entrypoint.sh /home/hadoop/hadoop-entrypoint.sh

# Set up SSH for Hadoop
RUN mkdir /var/run/sshd \
    && ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && chmod 0600 /root/.ssh/authorized_keys \
    && chown -R hadoop:hadoop /root/.ssh

# Copy MySQL JDBC driver
COPY mysql-connector-java-8.0.25.jar $SQOOP_HOME/lib/

# Set up Sqoop environment
RUN echo "export HADOOP_COMMON_HOME=$HADOOP_HOME" >> $SQOOP_HOME/conf/sqoop-env.sh \
    && echo "export HADOOP_MAPRED_HOME=$HADOOP_HOME" >> $SQOOP_HOME/conf/sqoop-env.sh

# Set ownership
RUN chown -R hadoop:hadoop $HADOOP_HOME $SQOOP_HOME

# Make the entrypoint script executable
RUN chmod +x /home/hadoop/hadoop-entrypoint.sh

USER hadoop
# Set the entrypoint to the custom script
ENTRYPOINT ["bash", "-c", "sudo service ssh start && source /home/hadoop/hadoop-entrypoint.sh"]
