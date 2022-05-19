FROM golang:alpine as builder

WORKDIR /go/app

COPY ./go .

RUN go mod init desafio.com/rocks

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" .

run rm main.go && rm go.mod

FROM scratch

WORKDIR /go/app

COPY --from=builder /go/app/rocks /usr/bin/

ENTRYPOINT ["rocks"]