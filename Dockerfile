# Этап сборки
FROM golang:1.18-alpine

WORKDIR /app

# Копируем модуль и файл с зависимостями
COPY go.mod go.sum ./
RUN go mod tidy
RUN go mod download

# Копируем весь исходный код
COPY . .

# Собираем бинарник
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o /main main.go

# Финальный образ
FROM alpine:latest

WORKDIR /root/

# Копируем только скомпилированный бинарник из этапа сборки
COPY --from=builder /main .

CMD ["/main"]