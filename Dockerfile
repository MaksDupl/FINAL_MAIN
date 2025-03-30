# Этап сборки
FROM golang:1.23 AS builder

WORKDIR /app

# Копируем модуль и файл с зависимостями
COPY go.mod go.sum ./
RUN go mod tidy

# Копируем весь исходный код
COPY . .

# Собираем бинарник
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main main.go

# Финальный образ
FROM alpine:latest

WORKDIR /root/

# Копируем только скомпилированный бинарник из этапа сборки
COPY --from=builder /main .

CMD ["/main"]