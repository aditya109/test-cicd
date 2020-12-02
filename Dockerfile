# Making this multi-step build

# Step 1: Build go-binary for test-cicd
FROM golang:1.14-alpine as build-env
EXPOSE 8080
RUN apk add --update --no-cache ca-certificates git && \
    mkdir /test-cicd
WORKDIR /test-cicd
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -o /go/bin/test-cicd

# Step 2: Copy the go-binary into test-cicd
FROM scratch
COPY --from=build-env /go/bin/test-cicd /go/bin/test-cicd
ENTRYPOINT ["/go/bin/test-cicd"]

# docker build --tag daitya96/test-cicd:v1.0 .