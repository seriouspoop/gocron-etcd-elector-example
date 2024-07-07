# Use alpine image for minimal size
FROM golang:alpine AS builder

# Set working directory
WORKDIR /app

# Download dependencies
COPY go.mod ./
RUN go mod download

# Copy your application code
COPY . .

# Build the application (replace main.go with your entrypoint)
RUN go build -o main ./main.go

# Use a smaller alpine image for final container
FROM alpine

# Copy the binary from builder stage
COPY --from=builder /app/main /app/main

# Set working directory
WORKDIR /app

# Expose port (replace 8080 with your application port)
EXPOSE 8080

# Run the application
CMD ["./main"]
