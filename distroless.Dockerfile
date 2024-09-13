FROM golang:1.23 AS build

WORKDIR /app

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /myapp

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /myapp /myapp

EXPOSE 8181

USER nonroot:nonroot

ENTRYPOINT [ "/myapp" ]