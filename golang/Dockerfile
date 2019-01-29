FROM alpine:latest

MAINTAINER SRE RCL (tech@rcl.co.id)

# install ca-certificates to fix problem https://github.com/docker-library/golang/issues/97
# without installing this certificates, all golang app inside docker container can't make outgoing https call'
RUN apk update && apk add ca-certificates

# change timezone
RUN apk add --update tzdata
ENV TZ=Asia/Jakarta

# for panics
RUN mkdir -p /var/log/app/

# all binary should be in /app folder
RUN mkdir -p /app
WORKDIR /app
COPY app /app

ENV PATH=${PATH}:/app
CMD ["./app"]
EXPOSE 8000