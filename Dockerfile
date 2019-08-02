FROM golang:1.12.4-alpine3.9
RUN apk add --no-cache git
ADD . /
WORKDIR /app
RUN go build -o main .
CMD ["/app/main"]
