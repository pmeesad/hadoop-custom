FROM python:3.12

# Install MySQL client
RUN apt update && apt install -y default-mysql-client


# Install JupyterLab and other necessary packages
RUN pip install --upgrade pip && pip install --no-cache-dir jupyterlab jupyter_server \ 
    numpy pandas sqlalchemy matplotlib pymongo hdfs mysql-connector-python thrift \
    thrift_sasl pyhive pyspark  

# Create necessary directories
RUN mkdir -p /opt/jupyter/work

# Set the working directory
WORKDIR /opt/jupyter/work

# Copy the entrypoint script into the container
COPY jupyter_entrypoint.sh /usr/local/bin/jupyter_entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/jupyter_entrypoint.sh

# Expose the JupyterLab port
EXPOSE 8888

# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/jupyter_entrypoint.sh"]
