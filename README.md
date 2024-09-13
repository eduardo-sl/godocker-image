# Optimized Go Docker Images

This repository offers a streamlined alternative to Alpine images by utilizing Distroless or Scratch images to run Go applications in Docker. By leveraging the power of multi-stage builds, you can use multiple FROM statements in a single Dockerfile. Each FROM statement initiates a new build stage, allowing you to create more efficient and smaller Docker images by separating the build environment from the runtime environment.

The reduction in image size is remarkable! Check out the numbers in the screenshot below:

![Image showing the reduction in image size](image.png)

## Building and Running the Images

### Distroless Image

To build the Distroless image:
```bash
docker build -t myapp-distroless -f distroless.Dockerfile .
```

To run the Distroless image:
```bash
docker run -p 8181:8181 myapp-distroless
```

### Scratch Image

To build the Scratch image:
```bash
docker build -t myapp-scratch -f scratch.Dockerfile .
```

To run the Scratch image:
```bash
docker run -p 8181:8181 myapp-scratch
```

## Additional Information

- About Distroless Image: 
Distroless images are a type of container image that includes only your application and its runtime dependencies, without any additional libraries, package managers, or shells that are typically found in standard Linux distributions. This approach results in significantly smaller and more secure images.
[GoogleContainerTools - Distroless](https://github.com/GoogleContainerTools/distroless)

- About Scratch Image: 
Scratch images are minimal Docker images that contain only the essential components needed to run your application. They are essentially empty images, which means they don’t include any operating system or additional libraries. This approach results in extremely small and efficient images.
[Docker Hub - Scratch](https://hub.docker.com/_/scratch)