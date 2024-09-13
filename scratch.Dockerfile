FROM golang:1.23 AS build

WORKDIR /app

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /myapp

FROM scratch

WORKDIR /

COPY --from=build /myapp /myapp

EXPOSE 8181

ENTRYPOINT [ "/myapp" ]