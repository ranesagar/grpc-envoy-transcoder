build:
	mkdir -p google && \
    git clone --depth=1 https://github.com/googleapis/googleapis.git googleapis && \
    cp -r googleapis/google/api google && \
    rm -rf googleapis

	protoc -I=./google -I=. --go_out=. --go-grpc_out=. item.proto

	go mod tidy
	go build -o item_service .

run:
	./item_service

clean:
	rm -rf google googleapis generated