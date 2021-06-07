.PHONY: build run

build:
	go build -o rest-beer api/main.go

run:
	go run api/main.go

test:
	go test github.com/cdiogo/restbeer/core/beer
