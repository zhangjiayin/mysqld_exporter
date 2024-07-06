FROM golang:1.21
WORKDIR /go/src/mysqld_exporter
COPY . .
#ENV GOPROXY=https://goproxy.cn GO111MODULE=on
ENV GOPROXY=https://goproxy.io,direct GO111MODULE=on
RUN make build


FROM quay.io/prometheus/busybox-linux-amd64:latest
LABEL maintainer="The Prometheus Authors <prometheus-developers@googlegroups.com>"
COPY mysqld_exporter /bin/mysqld_exporter

EXPOSE      9104
USER        nobody
ENTRYPOINT  [ "/bin/mysqld_exporter" ]
