FROM golang:1.11 as golang

WORKDIR /go/src/app

COPY . .

RUN GO111MODULE=on CGO_ENABLED=0 go install -v . ./cmd/...

RUN echo $GOPATH
RUN ls /go/bin
#USER bitcoin

FROM alpine:3.9

COPY --from=golang /go/bin /usr/local/bin

RUN addgroup -S btcd && adduser -S btcd -G btcd

USER btcd

CMD [ "btcd" ]