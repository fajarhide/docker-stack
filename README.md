# docker-stack
Dockerstack RCL lightweight images

## Beanstalkd
```sh
$ cd docker-stack/beanstalkd/
$ docker build -t rcl/beanstalkd .
$ mkdir data
$ docker run -d -p 11300:11300 -v $(pwd)/data:data rcl/beanstalkd
```

## MySQL
Edit enviroment `username`,`password` on `.env`
```sh
$ cd docker-stack/mysql/
$ mkdir data
$ docker-compose up -d
```

## Nginx-PHP-Phalcon
Edit enviroment `Project Name`,`port` on `.env`
```sh
$ cd docker-stack/nginx-php-phalcon/
$ ./build.sh
```