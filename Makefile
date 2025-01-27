.PHONY: build run clean

# Build the Docker images for the gRPC service and client
# Build the Docker images for the gRPC service, Envoy proxy, and client
build:
	# Generate the Protocol Buffers descriptor file: 
	# Details here: https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/grpc_json_transcoder_filter#how-to-generate-proto-descriptor-set
	# protoc -I=./item_service --include_imports --include_source_info \
	# --descriptor_set_out=./envoy_proxy/descriptor.pb ./item_service/item.proto

	if [ ! -d "googleapis" ]; then \
		git clone --depth=1 https://github.com/googleapis/googleapis.git googleapis; \
	fi

	protoc -I=./item_service -I=./googleapis --include_imports --include_source_info \
	--descriptor_set_out=./envoy_proxy/descriptor.pb \
	./item_service/item.proto

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