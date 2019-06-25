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
### Laravel
```sh
$ docker exec -it project-name sh -c "php artisan key:generate"
```

## Golang
```sh
$ cd docker-stack/golang/
$ CGO_ENABLED=0 GOOS=linux go build -a -o app .
$ docker build . -t name-project
$ docker run -it --name name-project -p 9000:8000 -d name-project
```

## Redis
```sh
$ cd docker-stack/redis/
$ mkdir data
$ docker-compose up -d
```

## Rabbitmq
```sh
$ cd docker-stack/rabbitmq/
$ docker-compose up -d
```