package server

import (
	"context"
	pb "github.com/wcygan/grpc-toy-go/api/golang/hello"
	"log"
)

type Server struct {
	pb.UnimplementedGreeterServer
}

func NewServer() *Server {
	return &Server{}
}

func (s *Server) SayHello(ctx context.Context, in *pb.HelloRequest) (*pb.HelloReply, error) {
	log.Printf("Received: %v", in.GetName())
	return &pb.HelloReply{Message: "Hello " + in.GetName()}, nil
}
