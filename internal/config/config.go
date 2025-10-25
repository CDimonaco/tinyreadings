package config

import "github.com/caarlos0/env/v11"

type Config struct {
	DBHost     string `env:"DB_HOST,required"`
	DBUser     string `env:"DB_USER,required"`
	DBPassword string `env:"DB_PASSWORD,required"`
	DBPort     int    `env:"DB_PORT,required"`
	DBName     string `env:"DB_NAME,required"`
	Env        string `env:"ENV"                  envDefault:"development"`
}

func LoadConfig() (*Config, error) {
	config := Config{}
	err := env.Parse(&config)
	if err != nil {
		return nil, err
	}
	return &config, nil
}
