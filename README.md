# Go API Counter

The purpose of this program is to increment a counter each time the endpoint is hit

## Getting started

These directions will guide you to getting the project setup, modifying, and running the counter.

### Prerequisites

* GOLANG 1.13.3 or newer
* git
* docker

### Nice to haves

* brew
* Postman

# Initial Project Setup

After the prerequisites are met.

- git clone this project

## Building the binary
From the directory run the following command.
```
go build
```

## Building the image
From the main directory run the following command.
```
docker build -t go-api-counter:<image_tag> .
```

### Passing in through the command line
```
docker run -p <port outside container>:8080 go-api-counter:<image_tag>
```

## Making Changes
### Creating a branch
When creating a new branch you will branch from develop. Either use the Stash UI or from the terminal while on the develop branch.
```
git branch <your branch name>
```

### Commit your changes
Once you are done making changes you will commit your changes back to develop.
```
git commit -am "your message here"
```
Then make a pull request for everyone to review your changes.

## Profiling the project
With the service running you can visit the /debug/pprof/ endpoint to view a multitude of profiling features.

For any generated profiles you can use this command to start a web server to view them.
```
go tool pprof -http=127.0.0.1:6060 <profile>
```

For any generated traces you can use this command to start a web server to view them.
```
go tool trace <trace>
```

# Brew osx package manager
Can be found here with instructions on how to install https://brew.sh/

# golang
Can be found here https://golang.org/

Installing with brew:
```
brew install go
```

# git
```
brew install git
```

# postman
Postman is a useful tool to help you mock up and send requests to your API endpoints.
```
brew cask install postman
```