build:
	protoc -I=./proto --go_out=. --go-grpc_out=. ./proto/item.proto

	go mod tidy
	go build -o item_service .

run:
	./item_service

clean:
	rm -rf generated