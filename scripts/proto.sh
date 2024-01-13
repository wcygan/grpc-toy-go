#!/bin/bash

# Go to the schemas directory (hint: run this script from the root directory)
cd api

# Specify the service names
SERVICES=("hello")

# Iterate over each service
for SERVICE_NAME in "${SERVICES[@]}"; do
    echo "Processing service: $SERVICE_NAME"

    mkdir -p golang/${SERVICE_NAME}

    # Run protoc for each service
    protoc --go_out=./golang --go_opt=paths=source_relative \
      --go-grpc_out=./golang --go-grpc_opt=paths=source_relative \
      ./${SERVICE_NAME}/*.proto

    # initialize go module
    cd golang/${SERVICE_NAME}
    go mod init \
      github.com/wcygan/grpc-toy-go/golang/${SERVICE_NAME} || true
    go mod tidy

    # Go back to the original directory
    cd ../../
done

# Go to the root directory
cd ..

echo "All services processed."
