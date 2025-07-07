#!/bin/bash
set -e

# Run migrations
python manage.py migrate --no-input

# Start Gunicorn in the background
gunicorn secure_django.wsgi:application \
    --bind unix:/run/gunicorn.sock \
    --workers 3 \
    --log-level=info \
    --access-logfile /var/log/gunicorn/access.log \
    --error-logfile /var/log/gunicorn/error.log &

# Start Nginx in the foreground
nginx -g 'daemon off;'