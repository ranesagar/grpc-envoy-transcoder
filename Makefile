.PHONY: build run clean

# Build the Docker images for the gRPC service, Envoy proxy, and client
build:
	# Build the item_service Docker image
	docker build -t item_service ./item_service

	# Build the client_service Docker image
	# docker build -t client_service ./client_service

# Run the gRPC service, Envoy proxy, and client
run:
	docker-compose up

test:
	@echo Testing REST request..
	curl -X POST http://localhost:8080/v1/item/get \
		-H "Content-Type: application/json" \
		-d '{"id": "123"}'

	@echo Testing gRPC request..
	grpcurl -plaintext -proto client_service/item.proto -d '{"id": "123"}' localhost:8080 item.ItemService/GetItem


# Clean up Docker containers and images
clean:
	docker-compose down
	docker rm -vf $(docker ps -aq)
	docker rmi -f $(docker images -aq)