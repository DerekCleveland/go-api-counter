package main

import (
	"fmt"
	"log"
	"net/http"
)

var counter int

func handleHello(w http.ResponseWriter, r *http.Request) {
	counter++
	fmt.Fprintf(w, "COUNTER = %d", counter)
}

func main() {
	counter = 0
	http.HandleFunc("/", handleHello)

	log.Fatal(http.ListenAndServe(":8080", nil))
}
