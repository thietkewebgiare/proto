init:
	cd third_party && \
		git clone https://github.com/protocolbuffers/protobuf.git src/google/protobuf && \
		git clone https://github.com/googleapis/googleapis.git google/api && \
		git clone https://github.com/bufbuild/protoc-gen-validate.git validate/

install:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28.1
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2.0
	go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v2.15.0
	go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2@v2.15.0

.PHONY: api
 # generate api proto
api:
	protoc 	--proto_path=./ \
		   	--proto_path=./third_party \
		  	--go_out=paths=source_relative:. \
			--go-grpc_out=paths=source_relative:. \
			--grpc-gateway_out=paths=source_relative:. \
			--openapiv2_out=. --openapiv2_opt=logtostderr=true\
			--openapiv2_opt=allow_merge=true,merge_file_name=openapiv2 \
		   	$(shell find find common user -type f -name "*.proto")