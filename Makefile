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

# Clean up Docker containers and images
clean:
	docker-compose down
	docker rm -vf $(docker ps -aq)
	docker rmi -f $(docker images -aq)