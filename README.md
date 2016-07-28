# docker-centos-cscart

This container is CS-Cart environment.

* OS: CentOS 7
* PHP v5.6

## Requier

* CS-Cart files. Please official download.
	* https://www.cs-cart.com/
	* If japanese : http://cs-cart.jp/
* Link MySQL or MariaDB container.

## Environment

### SETUP_HTTPD_CONF_NAME

* default : `setup.conf`

name of the configuration file.

### SERVER_NAME

* default : `localhost:80`

httpd `ServerName` config.

### STDOUT_ERROR_LOG

* default : `TRUE`
* `TRUE` or `FALSE`

add `ErrorLog /dev/stdout` to config.

### STDOUT_CUSTOM_LOG

* default : `TRUE`
* `TRUE` or `FALSE`

add `CustomLog /dev/stdout combined` to config.

## Run

```
docker run -it \
	--name <This container name> \
	--link <Your MySQL or MariaDB container>:<alias name> \
	-v <Your develop directory>:/var/www/html \
	reneice/docker-centos-cscart
```

## Example

### docker-compose.yml

```yml
version: '2'
services:
    cscart:
        container_name: my-cscart
        # build: ./dockerfiles/centos7-cscart-php56
        image: reneice/docker-centos-cscart
        environment:
            SERVER_NAME: www.example.com:80
            STDOUT_ERROR_LOG: "TRUE"
            STDOUT_CUSTOM_LOG: "FALSE"
        ports:
            - 8101:80
        volumes:
            - ./docroot:/var/www/html
        links:
            - db:db
        tty: true
    db:
        container_name: my-cscart-mariadb
        image: mariadb
        ports:
            - 3306:3306
        volumes:

            # I used to because of mysqldump or exec sql files.
            # If do not use please delete.
            - ./mariadb/other_data:/other_data

            # If Mac of Windows is Permission Error occurs.
            # Sorry. I still do not know the solution.
            # - ./mariadb/database:/var/lib/mysql

        environment:
            MYSQL_ROOT_PASSWORD: cscart
            MYSQL_DATABASE: cscart
            MYSQL_USER: cscart
            MYSQL_PASSWORD: cscart
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
