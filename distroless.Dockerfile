# Stage 1: Build the application
FROM docker.io/golang:1.26-bookworm AS builder

ARG TARGETOS=linux
ARG TARGETARCH=amd64

ENV CGO_ENABLED=0

# Set the working directory
WORKDIR /app

# Copy go.mod and go.sum and download dependencies
COPY go.mod go.sum ./
RUN --mount=type=cache,target=/go/pkg/mod \
    go mod download

# Copy the source code
COPY . .

# Use cache mounts for GOCACHE and GOMODCACHE and build the application
RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/go/pkg/mod \
    GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -ldflags="-s -w" -o /app/myapp

# Stage 2: Create the final image
FROM gcr.io/distroless/static-debian12

# Copy the compiled binary from the builder stage
COPY --from=builder /app/myapp /myapp

# Expose the application port
EXPOSE 8181

# Use a non-root user
USER nonroot:nonroot

# Command to run the application
ENTRYPOINT ["/myapp"]
