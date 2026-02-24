# Guía de Levantamiento del VPS (AWS Lightsail o EC2)

---

## 📋 Tabla de Contenidos
1. [Node.js](#1-nodejs)
2. [PM2](#2-pm2)
3. [Nginx](#3-nginx)
4. [Certbot](#4-certbot)
5. [GitHub](#5-github)

---

## 1. Node.js

```bash
# Instalar nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Cargar nvm
\. "$HOME/.nvm/nvm.sh"

# Instalar Node.js v24
nvm install 24

# Verificar instalación
node -v  # → v24.12.0
npm -v   # → 11.6.2
```

---

## 2. PM2 (Process Manager)

```bash
npm install pm2 -g
```

---

## 3. Nginx

### 3.1 ¿Qué es un Reverse Proxy?

Un reverse proxy es un servidor que se coloca entre los clientes (internet) y tus servidores internos (backend):

```
         Internet
             |
     ┌────────────────┐
     │  NGINX (RP)    │   ← Reverse Proxy
     └────────────────┘
       |           |
 ┌───────────┐ ┌───────────┐
 │ Backend A │ │ Backend B │
 └───────────┘ └───────────┘
```

### 3.2 Instalación

**Ubuntu/Debian:**
```bash
sudo apt update
sudo apt upgrade -y
sudo apt install nginx -y
```

**CentOS/RHEL/Fedora:**
```bash
sudo dnf update -y
sudo dnf install -y nginx
```

**Amazon Linux 2023:**
```bash
sudo dnf update -y
sudo dnf install -y nginx
```

### 3.3 Comandos básicos
```bash
sudo systemctl enable nginx   # Iniciar con el sistema
sudo systemctl start nginx    # Iniciar servicio
sudo systemctl status nginx  # Ver estado
sudo systemctl restart nginx # Reiniciar
```

### 3.4 Estructura de archivos

| Ubicación | Uso |
| --------- | ---- |
| `/etc/nginx/nginx.conf` | Archivo principal, configuraciones globales |
| `/etc/nginx/conf.d/*.conf` | Configuraciones de sitios (Amazon Linux) |
| `/etc/nginx/sites-available/` | Sitios disponibles (Ubuntu/Debian) |
| `/etc/nginx/sites-enabled/` | Sitios habilitados (Ubuntu/Debian) |
| `/var/www/html` | Archivos estáticos (Ubuntu/Debian) |
| `/usr/share/nginx/html` | Archivos estáticos (Amazon Linux) |

### 3.5 Comparativa por Sistema Operativo

| Ubuntu / Debian | Amazon Linux 2023 |
| --------------- | ----------------- |
| `/etc/nginx/sites-available/` | **NO existe** |
| `/etc/nginx/sites-enabled/` | **NO existe** |
| `/etc/nginx/conf.d/*.conf` | Aquí van los configs |
| `/var/www/html` | `/usr/share/nginx/html` |

### 3.6 Configuraciones

#### a) Reverse Proxy básico (HTTP)

Archivo: `/etc/nginx/conf.d/mi-sitio.conf` (Amazon Linux) o `/etc/nginx/sites-available/mi-sitio` (Ubuntu)

```nginx
server {
    listen 80;
    server_name midominio.com www.midominio.com;

    location / {
        add_header X-Backend-Host $hostname;
        proxy_pass http://127.0.0.1:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

#### b) Reverse Proxy con SSL (HTTPS)

**Generar certificado SSL:**
```bash
sudo certbot --nginx -d midominio.com -d www.midominio.com
sudo certbot renew --dry-run
```

**Configuración Nginx:**
```nginx
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name midominio.com www.midominio.com;

    ssl_certificate     /etc/letsencrypt/live/midominio.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/midominio.com/privkey.pem;
    include             /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam         /etc/letsencrypt/ssl-dhparams.pem;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# Redirigir HTTP a HTTPS
server {
    listen 80;
    listen [::]:80;

    server_name midominio.com www.midominio.com;
    return 301 https://$host$request_uri;
}
```

#### c) Load Balancer con SSL

```nginx
upstream api_cluster {
    server 10.0.0.101:3000;
    server 10.0.0.102:3000;
    server 10.0.0.103:3000;
}

server {
    listen 443 ssl;
    server_name midominio.com www.midominio.com;

    ssl_certificate     /etc/letsencrypt/live/midominio.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/midominio.com/privkey.pem;
    include             /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam         /etc/letsencrypt/ssl-dhparams.pem;

    location / {
        proxy_pass http://api_cluster;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

# Redirigir HTTP a HTTPS
server {
    listen 80;
    server_name midominio.com www.midominio.com;
    return 301 https://$host$request_uri;
}
```

#### Habilitar sitio (Ubuntu/Debian)
```bash
sudo ln -s /etc/nginx/sites-available/mi-sitio /etc/nginx/sites-enabled/
sudo nginx -t           # Verificar configuración
sudo systemctl reload nginx
```

---

## 4. Certbot (SSL/HTTPS)

```bash
sudo apt update
sudo apt install certbot python3-certbot-nginx
```

**Renovación automática:**
```bash
sudo certbot renew --dry-run
```

---

## 5. GitHub (Deploy Keys)

### 5.1 Generar clave SSH
```bash
ssh-keygen -t ed25519 -C "deploy@server"
```
> genera:
> - Clave privada: `~/.ssh/id_ed25519`
> - Clave pública: `~/.ssh/id_ed25519.pub`

### 5.2 Configurar SSH
Crear archivo `~/.ssh/config`:
```bash
Host mi_config
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes
```

### 5.3 Agregar Deploy Key
1. Ir a GitHub → **Settings** → **Deploy keys** → **Add deploy key**
2. Copiar contenido de:
```bash
cat ~/.ssh/id_ed25519.pub
```

### 5.4 Configurar remoto Git
```bash
cd dir_del_repo
git remote set-url origin git@mi_config:ORG/REPO.git
```

### 5.5 Verificar conexión
```bash
# Probar conexión
ssh -T git@mi_config

# Ver remotos configurados
git remote -v
# Expected:
# origin git@mi_config:ORG/REPO.git (fetch)
# origin git@mi_config:ORG/REPO.git (push)
```

---

## ✅ Verificación rápida después del setup

| Servicio | Comando de verificación |
|----------|------------------------|
| Node.js  | `node -v && npm -v`   |
| PM2      | `pm2 list`             |
| Nginx    | `sudo systemctl status nginx` |
| Nginx config test | `sudo nginx -t` |
| Git      | `ssh -T git@mi_config` |
| SSL      | `sudo certbot renew --dry-run` |
