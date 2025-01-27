package main

import (
	"context"
	"log"
	"net"

	pb "item_service/generated" // Import the generated package

	"google.golang.org/grpc"
)

type server struct {
	pb.UnimplementedItemServiceServer
}

func (s *server) GetItem(ctx context.Context, req *pb.GetItemRequest) (*pb.Item, error) {
	log.Printf("Received request for item ID: %s", req.Id)
	return &pb.Item{
		Id:          req.Id,
		Name:        "Sample Item",
		Description: "This is a sample item for testing.",
	}, nil
}

func main() {
	lis, err := net.Listen("tcp", ":9090")
	if err != nil {
		log.Fatalf("Failed to listen: %v", err)
	}

	s := grpc.NewServer()
	pb.RegisterItemServiceServer(s, &server{})

	log.Println("gRPC server is running on :9090")
	if err := s.Serve(lis); err != nil {
		log.Fatalf("Failed to serve: %v", err)
	}
}
