# Barabend

This is the source code for the API behind <barabend.com>. <Barabend.com> provided the user with a lot of usefull information about bars.
The backend is written in Perl and uses the Webframework Mojolicious.


## Prerequesits

You need 
* at least [Perl 5.20](https://perl.org)
* a MariaDB (recommended) or MySQL database

## Installation

Clone this repository

```
git clone git@github.com:onefloid/barabend-api.git
```

Then install the dependencies with [cpanm](https://metacpan.org/pod/cpanm)

```
cpanm --installdeps .
```

## Init application

Before you start with this application, you need to create a database and
configure the application.

Open a mysql shell

```
sudo mysql
```

Create sql user

```
CREATE USER 'barabend'@'localhost' IDENTIFIED BY '<password>';
```

Fill the configuration file  `barabend.yml` with user and password for the database

```yaml
sql_user: barabend
sql_pw: <password>
```

Create the database

```
CREATE DATABASE barabend;
```

Go back to command line

```
exit
```

Create the database schema with the migrate command

```
sudo ./script/barabend migrate
```

## Run Development

Run `morbo script/barabend`

Please notice morbo is a webserver for development. For production use hypnototad. 

## Run Production (Linux)

### Create os user
sudo useradd -m -s /bin/bash barabend

### Create script to start and stop web server
```
#!/bin/bash
cd ~/barabend
if [ $1 = "start" ]; then
        hypnotoad script/barabend -f
elif [ $1 = "restart" ]; then
        hypnototad script/barabend
elif [ $1 = "stop" ]; then
        hypnotoad -s script/barabend
fi
```

### Create service file
/etc/systemd/system/barabend.service

```
[Unit]
Description=Service to run barabend web app
After=network.target

[Service]
Type=simple
TimeoutStartSec=5m
Restart=always
RestartSec=30s
User=barabend
ExecStart=/home/barabend/barabend/start.sh start
ExecReload=/home/barabend/barabend/start.sh restart
ExecStop=/home/barabend/barabend/start.sh stop
KillMode=process
SyslogIdentifier=barabend
[Install]
WantedBy=multi-user.target

```
###Create Service

```
sudo systemctl daemon-reload
sudo systemctl enable filename.service
sudo systemctl start filename.service
sudo systemctl status filemane.service
```

### Use lets encrypt certificates
Use certbot to get your certificates
https://letsencrypt.org/de/getting-started/

### Configure nginx
Create config file 
 /etc/nginx/conf.d/barabend.conf
```
upstream barabend  {
  server 127.0.0.1:40000;
}

#...

```

Test config file
```
nginx -t
```

Restart nginx
```
systemctl restart nginx
```

### Generate password digest from command line

```
perl -M'Crypt::Digest::SHA3_224("sha3_224_b64")' -e "print( sha3_224_b64('<your-paaword>').qq{\n} )"
```