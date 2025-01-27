.PHONY: build run clean

# Build the Docker images for the gRPC service and client
# Build the Docker images for the gRPC service, Envoy proxy, and client
build:
	# Build the item_service Docker image
	docker build -t item_service ./item_service

# Run the gRPC service, Envoy proxy, and client
run:
	docker-compose up

# Clean up Docker containers and images
clean:
	docker-compose down
	docker rmi item_service