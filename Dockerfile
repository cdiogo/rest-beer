FROM golang:alpine AS builder

# Set necessary environmet variables needed for our image
ENV GO111MODULE=on \
    # CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Move to working directory /build
WORKDIR /build

# Copy and download dependency using go mod
# COPY go.mod .
# COPY go.sum .

# Copy the code into the container
COPY . .
RUN go mod download

# Build the application
RUN go build  -o /build/rest-beer /build/api/main.go

# Build a small image
FROM scratch

COPY --from=builder /build/rest-beer /
COPY /data/beer.db /data/beer.db
# Command to run
ENTRYPOINT ["/rest-beer"]
