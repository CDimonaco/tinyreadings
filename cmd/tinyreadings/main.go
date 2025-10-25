package main

import (
	"fmt"

	"github.com/cdimonaco/tinyreadings/internal/version"
)

func main() {
	fmt.Printf(
		"Hello, TinyReadings!, Version: %s, Build Date: %s\n",
		version.Version,
		version.BuildDate,
	)
}
