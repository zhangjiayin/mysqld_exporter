FROM golang:1.21 
WORKDIR /go/src/mysqld_exporter 
COPY . . 
RUN make build   

FROM busybox:latest 
LABEL maintainer="The Prometheus Authors <prometheus-developers@googlegroups.com>" 
COPY  --from=0  /go/src/mysqld_exporter/mysqld_exporter /bin/mysqld_exporter  
EXPOSE      9104 
USER        nobody 
ENTRYPOINT  [ "/bin/mysqld_exporter" ] 
