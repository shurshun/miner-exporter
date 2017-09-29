FROM golang as BUILD

WORKDIR /go/src/app

COPY main.go claymore_dual_miner.go /go/src/app/

RUN go-wrapper download

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o claymore-exporter .

FROM shurshun/alpine-moscow

LABEL author "Korviakov Andrey"
LABEL maintainer "4lifenet@gmail.com"

HEALTHCHECK --interval=30s --timeout=2s \
  CMD nc -zv 127.0.0.1 9278

COPY --from=BUILD /go/src/app/claymore-exporter /usr/local/bin/

RUN find /usr/local/bin -type f -exec chmod +x {} \;

ENTRYPOINT ["claymore-exporter"]