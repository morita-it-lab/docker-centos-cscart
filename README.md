# docker-centos-cscart

This container is CS-Cart environment.

* OS: CentOS 7
* PHP v5.6

## Requier

* CS-Cart files. Please official download.
* link MySQL or MariaDB container.

## run

```
docker run -it \
	--name <This container name> \
	--link <Your MySQL or MariaDB container>:<alias name> \
	-v <Your develop directory>:/var/www/html \
	reneice/docker-centos-cscart
```

### example

#### docker run

```
docker run -itd \
	--name my_cscart \
	--link mariadb:mariadb \
	-v ~/docker/my_cscart:/var/www/html \
	-p 8101:80 \
	reneice/docker-centos-cscart
```

#### deploy cs-cart

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
