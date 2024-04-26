FROM docker.io/golang:1.22.2-alpine as builder

ENV GOPATH=/go

WORKDIR $GOPATH/src/github.com/kkohtaka/edgetpu-device-plugin

COPY go.mod go.mod
COPY go.sum go.sum

# this helps caching the dependencies and they don't need to be rebuilt all the time
RUN go mod download

# Copy the go source
COPY main.go main.go
COPY pkg/ pkg/

RUN CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH:-amd64} go build  -ldflags="-w -s" -a -o /bin/edgetpu-device-plugin .

FROM docker.io/library/alpine:3.19.1

COPY --from=builder /bin/edgetpu-device-plugin /bin/

ENTRYPOINT ["/bin/edgetpu-device-plugin"]
