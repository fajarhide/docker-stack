FROM alpine
MAINTAINER fajarhide <fajar@rcl.co.id>

## Add user beanstalkd
RUN addgroup -S beanstalkd && adduser -S -G beanstalkd beanstalkd

## Add Tini and Beanstalkd
RUN apk add --update --no-cache tini beanstalkd && rm -fr /var/cache/apk/*
ENTRYPOINT ["/sbin/tini", "--"]

## Create directory 
RUN mkdir /data && chown beanstalkd:beanstalkd /data
VOLUME ["/data"]

## Expose the port
EXPOSE 11300
CMD ["beanstalkd", "-p", "11300", "-b", "/data"]