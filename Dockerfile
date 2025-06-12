# syntax = docker/dockerfile:1.3
FROM golang:1.23 AS build
WORKDIR /go/src/github.com/mccutchen/go-httpbin
COPY . .
RUN make build buildtests
FROM gcr.io/distroless/base
COPY --from=build /go/src/github.com/mccutchen/go-httpbin/dist/go-httpbin* /bin/
EXPOSE 3000
CMD ["/bin/go-httpbin"]
