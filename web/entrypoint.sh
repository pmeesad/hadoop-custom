#!/bin/bash
set -e
echo "Starting entrypoint.sh script"

# Ensure django-admin is available
if ! command -v django-admin &> /dev/null; then
  echo "django-admin could not be found"
  exit 1
fi

# Check if the project directory already exists
if [ ! -d "$APP_HOME/proj" ]; then
  echo "Creating Django project"
  django-admin startproject proj .
fi

# Run migrations
python manage.py makemigrations
python manage.py migrate

# Run Django development server
echo "Starting Django development server"
exec python manage.py runserver 0.0.0.0:8000