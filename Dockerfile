# Use the official Golang image as the build environment
FROM golang:1.22.2-alpine AS builder

WORKDIR /app
COPY . .
RUN go build -o app

# Use a smaller image for the final container
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/app .
EXPOSE 8080
CMD ["./app"]
