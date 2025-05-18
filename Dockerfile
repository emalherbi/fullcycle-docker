FROM golang:1.21-alpine AS builder

WORKDIR /app

COPY main.go .

# Desativa o modo de módulos
ENV GO111MODULE=off

# Compila o binário de forma estática
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o app .

FROM scratch

COPY --from=builder /app/app .

EXPOSE 8080

ENTRYPOINT ["./app"]