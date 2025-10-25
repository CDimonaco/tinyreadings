package main

import (
	"github.com/cdimonaco/tinyreadings/internal/config"
	"github.com/cdimonaco/tinyreadings/internal/logger"
	"github.com/cdimonaco/tinyreadings/internal/version"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		panic(err)
	}
	config, err := config.LoadConfig()
	if err != nil {
		panic(err)
	}
	logger := logger.CreateLogger(config)

	logger.Info("TinyReadings starting up", "version", version.Version, "build", version.BuildDate)
}
