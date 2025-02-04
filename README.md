# gRPC Service with Envoy Proxy

This project demonstrates a gRPC service exposed via Envoy Proxy, which translates RESTful HTTP/JSON requests into gRPC calls.

## Directory Structure
- `item_service/`: Contains the gRPC service implementation.
- `client_service/`: Contains the gRPC client implementation.
    You can also run below commands from (3)
- `docker-compose.yml`: Orchestrates the gRPC service, Envoy proxy, and client.

## How to Run

1. Build the Docker images:
   ```bash
   make build
   ```

2. Run the gRPC service, Envoy proxy, and client:

   ```bash
   make run
   ```

3. Test the API:

   grpc request to the service[9090]:
   ```bash
   grpcurl -plaintext -proto item_service/item.proto -d '{"id": "123"}' localhost:9090 item.ItemService/GetItem
   ```

   grpc request to the proxy[8080]:
   ```bash
   grpcurl -plaintext -proto client_service/item.proto -d '{"id": "123"}' localhost:8080 item.ItemService/GetItem
   ```

   REST request to the proxy[8080] 
   ```bash
   curl -v -X POST http://localhost:8080/v1/item/get \
     -H "Content-Type: application/json" \
     -d '{"id": "123"}'
   ```

4. Clean up:

   ```bash
   make clean
   ```
