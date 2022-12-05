# build stage
FROM golang:1.19.3-alpine3.17 AS build-env
RUN apk --no-cache add build-base git gcc
ADD . /src
RUN cd /src/cmd && go build -o prometheus-aggregate-exporter

FROM alpine:latest
WORKDIR /app

ARG USER=nobody
USER nobody

COPY --from=build-env --chown=nobody /src/cmd/prometheus-aggregate-exporter /app/
ENTRYPOINT ["./prometheus-aggregate-exporter"]
