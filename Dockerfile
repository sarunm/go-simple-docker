FROM golang:1.20.7-alpine AS build_base

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 go test -v

RUN go build -o ./out/go-simple && chmod +x ./out/go-simple

# ======

FROM alpine:3.16.2

COPY --from=build_base /app/out/go-simple /app/go-simple

CMD ["/app/go-simple"]

