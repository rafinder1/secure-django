FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    gcc libpq-dev nginx openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/ssl/private /etc/ssl/certs /var/log/gunicorn

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip && pip install -r requirements.txt

COPY apka/ apka/
COPY secure_django secure_django/
COPY manage.py . 
COPY db.sqlite3 .

COPY nginx/secure-django.conf /etc/nginx/sites-available/secure-django

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/selfsigned.key \
    -out /etc/ssl/certs/selfsigned.crt \
    -subj "/C=PL/ST=Mazowieckie/L=Warszawa/O=IT-Learn/OU=IT/CN=127.0.0.1/emailAddress=rafpro33@gmail.com"

RUN ln -s /etc/nginx/sites-available/secure-django /etc/nginx/sites-enabled/

EXPOSE 443

COPY entrypoint.sh .
RUN chmod +x /app/entrypoint.sh

CMD ["/app/entrypoint.sh"]