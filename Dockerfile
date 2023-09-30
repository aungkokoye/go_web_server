FROM golang:1.20.5-alpine AS builder

WORKDIR /app

RUN apk add bash

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build main.go

FROM alpine:latest as production

WORKDIR /app

COPY --from=builder /app/main .