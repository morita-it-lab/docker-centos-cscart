# docker-centos-cscart

This container is CS-Cart environment.

* OS: CentOS 7
* PHP v5.6

## Requier

* CS-Cart files. Please official download.
* link MySQL or MariaDB container.

## Environment

### SETUP_HTTPD_CONF_NAME

* default : `setup.conf`

name of the configuration file.

### SERVER_NAME

* default : `localhost:80`

httpd `ServerName` config.

## Run

```
docker run -it \
	--name <This container name> \
	--link <Your MySQL or MariaDB container>:<alias name> \
	-v <Your develop directory>:/var/www/html \
	reneice/docker-centos-cscart
```

## Example

### docker-compose

```yml
version: '2'
services:
    cscart:
        container_name: cscart
        image: reneice/docker-centos-cscart
        environment:
            SERVER_NAME: www.example.com:80
        ports:
            - 80:80
        volumes:
            - ./docroot:/var/www/html
        links:
            - db:db
        tty: true
    db:
        container_name: mariadb
        image: mariadb
        ports:
            - 3306:3306
        volumes:
            - ./mariadb/other_data:/other_data
            - ./mariadb/database:/var/lib/mysql
        environment:
            MYSQL_PASSWORD: cscart
            MYSQL_USER: cscart
            MYSQL_DB: cscart
```

### Run

#### docker run

```
docker run -itd \
	--name my_cscart \
	--link mariadb:mariadb \
	-e SERVER_NAME=www.example.com:80 \
	-v ~/docker/my_cscart:/var/www/html \
	-p 8101:80 \
	reneice/docker-centos-cscart
```

### deploy cs-cart

```
cp cscart_v4.3.4_jp_1.zip ~/docker/my_cscart/
cd ~/docker/my_cscart/
unzip cscart_v4.3.4_jp_1.zip
chmod -R 777 config.local.php images design var
```

#### access

http://my_host:8101/

#### install cs-cart

Perform the installation according to the screen.

MySQL Server host is alias name.
this sample is **mariadb**.
