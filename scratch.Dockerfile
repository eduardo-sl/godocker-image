# Stage 1: Build the application
FROM docker.io/golang:latest AS builder

ENV CGO_ENABLED=0

# Set the working directory
WORKDIR /app

# Copy go.mod and go.sum and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code
COPY . .

# Use a cache mount for GOCACHE and build the application
RUN --mount=type=cache,target=/root/.cache/go-build \
go build -ldflags="-s -w" -o /app/myapp

# Stage 2: Create the final image
FROM scratch

# Copy the compiled binary from the builder stage
COPY --from=builder /app/myapp /myapp

# Expose the application port
EXPOSE 8181

# Use a non-root user
USER 1001:1001

# Copy the Pre-built binary file
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Command to run the application
ENTRYPOINT ["/myapp"]