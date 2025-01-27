# Use the official Golang image with Go 1.21
FROM golang:1.21

# Install protoc and the specific versions of the Go plugins
RUN apt-get update && apt-get install -y protobuf-compiler && \
    go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.31.0 && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.3.0

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy the source code
COPY . .

# Generate gRPC code
RUN protoc --go_out=. --go-grpc_out=. item.proto

# Build the Go application
RUN go build -o item_service .

# Expose the gRPC port
# EXPOSE 9090

# Run the application
CMD ["./item_service"]