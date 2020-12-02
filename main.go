// main.go

package main

import (
	"encoding/json"
	"github.com/gorilla/mux"
	"log"
	"net/http"
)

type R struct {
	Result  int    `json:"Result"`
	Message string `json:"Message"`
}

var response R

func welcome(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	err := json.NewEncoder(w).Encode(response)
	if err != nil {
		log.Fatal(err)
	}
}

func handleRequests() {
	router := mux.NewRouter().StrictSlash(true)
	router.HandleFunc("/", welcome).Methods("GET")
	log.Fatal(http.ListenAndServe(":8080", router))
}

func main() {
	response = R{
		Result: 1, Message: "Successful Hit !",
	}
	handleRequests()
}
