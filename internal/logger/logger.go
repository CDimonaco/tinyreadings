package logger

import (
	"log/slog"
	"os"

	"github.com/cdimonaco/tinyreadings/internal/config"
)

func CreateLogger(config *config.Config) *slog.Logger {
	opts := slog.HandlerOptions{
		Level: slog.LevelDebug,
	}
	var handler slog.Handler = slog.NewTextHandler(os.Stdout, &opts)
	if env := config.Env; env == "production" {
		handler = slog.NewJSONHandler(os.Stdout, &opts)
	}

	logger := slog.New(handler)

	logger.Info("Logger configured", "env", config.Env)

	return logger
}
