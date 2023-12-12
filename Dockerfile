FROM golang:alpine3.19 AS builder

WORKDIR /go/src/app

COPY ./src /go/src/app
RUN go build
RUN rm go.mod && rm hello.go

#Multistage building
FROM scratch
COPY --from=builder /go/src/app /go/bin/app
ENTRYPOINT ["/go/bin/app/hello"]