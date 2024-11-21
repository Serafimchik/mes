package main

import (
	"context"
	"log"
	"time"

	pb "test/proto"

	"google.golang.org/grpc"
)

func main() {
	conn, err := grpc.Dial(":50051", grpc.WithInsecure(), grpc.WithBlock())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()
	c := pb.NewChatServiceClient(conn)

	ctx, cancel := context.WithTimeout(context.Background(), time.Second)
	defer cancel()

	r, err := c.SendMessage(ctx, &pb.MessageRequest{Content: "Hello, world!"})
	if err != nil {
		log.Fatalf("could not send message: %v", err)
	}
	log.Printf("Response from server: %s", r.GetMessage())
}
