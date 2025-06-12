# syntax = docker/dockerfile:1.3
FROM golang:1.23 AS build
ARG RAILWAY_SERVICE_ID
WORKDIR /go/src/github.com/mccutchen/go-httpbin
COPY . .
RUN --mount=type=cache,id=s/$RAILWAY_SERVICE_ID-/root/.cache/go-build,target=/root/.cache/go-build \
    make build buildtests
FROM gcr.io/distroless/base
COPY --from=build /go/src/github.com/mccutchen/go-httpbin/dist/go-httpbin* /bin/
EXPOSE 3000
CMD ["/bin/go-httpbin"]
