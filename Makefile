.PHONY: build run clean

# Build the Docker images for the gRPC service, Envoy proxy, and client
build:
	# Generate the Protocol Buffers descriptor file: 
	protoc -I=./item_service -I=./item_service/proto/ --include_imports --include_source_info \
	--descriptor_set_out=./envoy_proxy/descriptor.pb \
	./item_service/proto/item.proto

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
	docker rmi item_service