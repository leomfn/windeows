FROM golang:1.23.1-alpine AS builder

RUN apk add build-base

WORKDIR /app

COPY go.mod go.sum ./

COPY *.go ./

RUN GOOS=linux GOARCH=amd64 go build -v -o ./windeows

FROM gcr.io/distroless/static-debian12

WORKDIR /app

COPY --from=builder /app/windeows ./windeows

COPY static/ ./static
COPY templates/ ./templates

ENTRYPOINT [ "/app/windeows" ]