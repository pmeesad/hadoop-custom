# Sqoop Dockerfile
FROM openjdk:8-jdk

# Set environment variables
ENV SQOOP_VERSION 1.4.7
ENV SQOOP_HOME /opt/sqoop
ENV HADOOP_HOME /opt/hadoop
ENV PATH $SQOOP_HOME/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Install necessary tools
RUN apt-get update && apt-get install -y wget

# Download and install Sqoop
RUN wget https://archive.apache.org/dist/sqoop/$SQOOP_VERSION/sqoop-$SQOOP_VERSION.bin__hadoop-2.6.0.tar.gz \
    && tar -xzvf sqoop-$SQOOP_VERSION.bin__hadoop-2.6.0.tar.gz -C /opt/ \
    && mv /opt/sqoop-$SQOOP_VERSION.bin__hadoop-2.6.0 $SQOOP_HOME \
    && rm sqoop-$SQOOP_VERSION.bin__hadoop-2.6.0.tar.gz

# Copy MySQL JDBC driver
COPY mysql-connector-java-8.0.25.jar /usr/local/sqoop/lib/

# Set up Sqoop environment
RUN echo "export HADOOP_COMMON_HOME=$HADOOP_HOME" >> $SQOOP_HOME/conf/sqoop-env.sh \
    && echo "export HADOOP_MAPRED_HOME=$HADOOP_HOME" >> $SQOOP_HOME/conf/sqoop-env.sh

# Create a directory for Sqoop jobs
RUN mkdir -p /sqoop-jobs

# Set the working directory
WORKDIR /sqoop-jobs

# Copy the entrypoint script
COPY sqoop-entrypoint.sh /sqoop-entrypoint.sh
RUN chmod +x /sqoop-entrypoint.sh

ENTRYPOINT ["/sqoop-entrypoint.sh"]