package main

import (
	"fmt"
	"net/http"

	jsoniter "github.com/json-iterator/go"
	"github.com/gofrs/uuid"
	"github.com/gorilla/mux"
	"github.com/gorilla/schema"
	"github.com/sirupsen/logrus"
)

type Data struct {
	ID      string `json:"id" schema:"id"`
	Message string `json:"message" schema:"message"`
}

func main() {
	// Initialize logger
	logrus.SetLevel(logrus.InfoLevel)
	
	// Create UUID
	id, _ := uuid.NewV4()
	
	// Create sample data
	data := Data{
		ID:      id.String(),
		Message: "Hello from test-nexus Go module",
	}
	
	// JSON serialization using json-iterator (similar to Jackson)
	json := jsoniter.ConfigCompatibleWithStandardLibrary
	jsonBytes, _ := json.Marshal(data)
	logrus.Info("JSON output: ", string(jsonBytes))
	
	// Schema encoding (similar to commons-codec)
	encoder := schema.NewEncoder()
	form := make(map[string][]string)
	encoder.Encode(data, form)
	logrus.Info("Form encoded data: ", form)
	
	// HTTP router setup
	r := mux.NewRouter()
	r.HandleFunc("/test", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.Write(jsonBytes)
	}).Methods("GET")
	
	fmt.Println("Go dependencies test setup complete!")
	fmt.Println("Similar to Maven project with Jackson and Commons-codec")
	fmt.Printf("Generated ID: %s\n", data.ID)
}