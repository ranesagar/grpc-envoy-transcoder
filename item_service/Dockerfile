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
RUN mkdir -p /data

# Generate gRPC code
RUN protoc -I=./proto --go_out=. --go-grpc_out=. ./proto/item.proto
# Generate descriptor file
RUN protoc -I=./proto/ --include_imports --include_source_info \
    --descriptor_set_out=/data/descriptor.pb \
    ./proto/item.proto

RUN cp envoy.yaml /data/envoy.yaml
# Build the Go application
RUN go build -o item_service .

# Expose the gRPC port
EXPOSE 9090

# Run the application
CMD ["./item_service"]