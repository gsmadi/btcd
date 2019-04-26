FROM golang:1.11 as builder

WORKDIR /go/src/app

COPY . .

RUN GO111MODULE=on CGO_ENABLED=0 go install -v . ./cmd/...

FROM alpine:3.9

COPY --from=builder /go/bin /usr/local/bin

RUN addgroup -S btcd && adduser -S btcd -G btcd

USER btcd

CMD [ "btcd" ]