FROM golang:alpine as builder
RUN mkdir /build 
ADD . /build/
WORKDIR /build 
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o dynpower-cli .
FROM scratch
COPY --from=builder /build/dynpower-cli /app/
WORKDIR /app
CMD ["./dynpower-cli"]