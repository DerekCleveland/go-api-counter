# Grab golang official alpine image and use as the build stage
FROM golang:1.13.3-alpine as builder

LABEL maintainer="Derek Cleveland <clevelanddtc@gmail.com>"

# Create appuser
# TODO was having permissions error with creating files when using this user
#RUN adduser -D -g '' appuser

WORKDIR $GOPATH/src/mypackage/myapp/

# Install git + SSL ca certificates.
# Git is required for fetching the dependencies.
# Ca-certificates is required to call HTTPS endpoints.
RUN apk update && apk add --no-cache git ca-certificates tzdata && update-ca-certificates

# use modules
COPY go.mod .

ENV GO111MODULE=on
RUN go mod download
RUN go mod verify

# Copy source directory files to container
COPY . .

# Change directory of particular main.go
WORKDIR cmd/GoApiCounter

# Build the binary
# CGO_ENABLED=0: Disables the use of CGO. While it should be disabled while cross compiling its not always the case
# GOOS=linux: target operating system linux
# ldfflags: -w turns off DWARF debugging information, -s turns off generation of the Go symbol table
# -a: force rebuilding of packages that are already up-to-date. Slows build time but know everything is built properly
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -a -o /go/bin/GoApiCounter .

############################
# BUILD 2 make a small image
############################
FROM scratch

# Import from builder.
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/passwd /etc/passwd

# Copy our static executable
COPY --from=builder /go/bin/GoApiCounter /go/bin/GoApiCounter

# Use an unprivileged user.
# TODO can renable once permissions error is resolved
#USER appuser

# Run the hello binary.
ENTRYPOINT ["/go/bin/GoApiCounter"]

# Document that the container uses port 8080 - this is just for documentation
EXPOSE 8080