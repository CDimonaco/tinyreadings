package logger

import (
	"log/slog"
	"os"

	"github.com/cdimonaco/tinyreadings/internal/config"
)

func ConfigureGlobalLogger(config config.Config) {
	opts := slog.HandlerOptions{
		Level: slog.LevelDebug,
	}
	var handler slog.Handler = slog.NewTextHandler(os.Stdout, &opts)
	if env := config.Env; env == "production" {
		handler = slog.NewJSONHandler(os.Stdout, &opts)
	}

	slog.SetDefault(slog.New(handler))

	slog.Info("Logger configured", "env", config.Env)
}
