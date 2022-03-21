FROM golang:1.17-alpine as builder
RUN mkdir /build
ADD . /build/
RUN find /build
WORKDIR /build
RUN GO111MODULE=auto GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o bin/commenter-linux-amd64 ./cmd/commenter



FROM alpine:3.12

RUN apk --no-cache --update add bash git \
    && rm -rf /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

COPY bin/commenter-linux-amd64 /usr/local/bin/commenter
RUN chmod +x /usr/local/bin/commenter
