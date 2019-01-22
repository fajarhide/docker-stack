# docker-stack
Dockerstack RCL lightweight images

## Beanstalkd :
```sh
$ cd docker-stack/beanstalkd/
$ docker build -t rcl/beanstalkd .
$ mkdir data
$ docker run -d -p 11300:11300 -v $(pwd)/data:data rcl/beanstalkd
```