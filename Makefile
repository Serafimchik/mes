LOCAL_BIN:=$(CURDIR)/bin

install-deps:
	set GOBIN=$(LOCAL_BIN) && go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28.1
	set GOBIN=$(LOCAL_BIN) && go install -mod=mod google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2

get-deps:
	go get -u google.golang.org/protobuf/cmd/protoc-gen-go
	go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc


generate:
	make generate-note-api

generate-note-api:
	powershell -Command "New-Item -ItemType Directory -Force -Path pkg/note_v1"
	protoc --proto_path=api/note_v1 \
	--go_out=pkg/note_v1 --go_opt=paths=source_relative \
	--plugin=protoc-gen-go=$(LOCAL_BIN)/protoc-gen-go.exe \
	--go-grpc_out=pkg/note_v1 --go-grpc_opt=paths=source_relative \
	--plugin=protoc-gen-go-grpc=$(LOCAL_BIN)/protoc-gen-go-grpc.exe \
	api/note_v1/note.proto