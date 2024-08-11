# Dockerfile
FROM python:3.10-bullseye

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV APP_HOME=/proj

# Create and set work directory
WORKDIR $APP_HOME

# Install system dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-utils tzdata systemd software-properties-common gcc python3-dev \
    python3-setuptools libpq-dev build-essential libxml2-dev libxslt1-dev \
    python3-lxml zlib1g-dev default-mysql-client default-libmysqlclient-dev \
    python3-tk python3-pip nano curl lsof gunicorn tree sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Copy entrypoint script
COPY entrypoint.sh /proj/entrypoint.sh
RUN chmod +x /proj/entrypoint.sh

# Run entrypoint.sh
ENTRYPOINT ["/proj/entrypoint.sh"]