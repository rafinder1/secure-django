# 🔐 Secure Django Deployment (Gunicorn + Nginx + SSL)

This guide walks you through deploying a Django project using:

- **Gunicorn** (WSGI HTTP Server)
- **Nginx** (reverse proxy + SSL termination)
- **Self-signed SSL certificate**

---

## 📁 Project Structure

```
secure_django/
├── apka/                    # Your Django app
├── secure_django/          # Django project settings
├── nginx/                  # nginx/secure-django.conf
├── gunicorn.service        # Gunicorn systemd unit
├── .env                    # Environment variables (SECRET_KEY, etc.)
├── db.sqlite3              # SQLite DB
└── manage.py
```

---

## ⚙️ 1. Generate a Self-Signed SSL Certificate

```bash
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/selfsigned.key \
-out /etc/ssl/certs/selfsigned.crt
```

### ❓ Fill in as:

```text
Country Name (2 letter code) [AU]: PL
State or Province Name (full name) [Some-State]: Mazowieckie
Locality Name (eg, city) []: Warszawa
Organization Name (eg, company) [Internet Widgits Pty Ltd]: IT-Learn
Organizational Unit Name (eg, section) []: IT
Common Name (e.g. server FQDN or YOUR name) []: xx.xx.xx.xx
Email Address []: rafpro33@gmail.com
```

---

## 🚀 2. Configure Gunicorn (Systemd)

Place the file:

```bash
sudo mv gunicorn.service /etc/systemd/system/gunicorn.service
```

### Then reload and start Gunicorn:

```bash
sudo systemctl daemon-reload
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo systemctl status gunicorn
```

---

## 🌐 3. Configure Nginx

Move and enable the site configuration:

```bash
sudo mv /nginx/secure-django.conf /etc/nginx/sites-available/secure-django
sudo ln -s /etc/nginx/sites-available/secure-django /etc/nginx/sites-enabled/
```

### Test and restart Nginx:

```bash
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl status nginx
```

---

## 🔍 4. Access Your Site

Open your browser and go to:

```bash
https://<your-server-ip>
```

> For example: `https://192.168.x.x`

⚠️ You’ll see a **security warning** because of the self-signed certificate.  
Click **Advanced → Continue Anyway**.

---


## 📦 .env File (Example)

```env
DEBUG=False
SECRET_KEY=your-secure-secret-key
ALLOWED_HOSTS=127.0.0.1,localhost,192.168.0.248
```

> And in your Django `settings.py`:
```python
import os
SECRET_KEY = os.getenv("SECRET_KEY")
DEBUG = os.getenv("DEBUG") == "True"
ALLOWED_HOSTS = os.getenv("ALLOWED_HOSTS").split(",")
```

---

## ✅ Done!

You now have a Django app securely running with SSL, Gunicorn, and Nginx 🎉

---

**Author:** rafpro33  
**Email:** rafpro33@gmail.com  
