FROM golang:1.23

WORKDIR /app

COPY . .

RUN go mod tidy

RUN CGO_ENABLED=0 go build -o ./${final-main}

CMD ["/main"]