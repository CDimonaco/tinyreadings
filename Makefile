APP_NAME := tinyreadings
PKG := github.com/cdimonaco/tinyreadings
MAIN := cmd/$(APP_NAME)/main.go
BIN := bin/$(APP_NAME)

# Versioning
VERSION := $(shell git describe --tags --always --dirty 2>/dev/null || echo "dev")
BUILD_DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

LDFLAGS := -ldflags "-X '$(PKG)/internal/version.Version=$(VERSION)' -X '$(PKG)/internal/version.BuildDate=$(BUILD_DATE)'"
MIGRATIONS_DIR := internal/database/migrations
MIGRATE := migrate
DEV_DB := postgres://tinyreadings:password@localhost:5432/tinyreadings?sslmode=disable

# Default target
.PHONY: all
all: build

## build: Compile the binary with version info
.PHONY: build
build:
	@echo "Building $(APP_NAME)..."
	@go build $(LDFLAGS) -o $(BIN) $(MAIN)
	@echo "Version: $(VERSION)"
	@echo "Build Date: $(BUILD_DATE)"

## lint: Run golangci-lint
.PHONY: lint
lint:
	@echo "Running golangci-lint..."
	@golangci-lint run ./...

## test: Run unit tests
.PHONY: test
test:
	@echo "Running tests..."
	@go test ./... -v

## clean: Remove built files
.PHONY: clean
clean:
	@echo "Cleaning up..."
	@rm -rf $(BIN)


## migrate-create: Create a new migration (usage: make migrate-create name=add_users_table)
.PHONY: migrate-create
migrate-create:
	@if [ -z "$(name)" ]; then \
		echo "❌ Please provide a migration name, e.g. 'make migrate-create name=add_users_table'"; \
		exit 1; \
	fi
	@echo "Creating migration '$(name)'..."
	@$(MIGRATE) create -ext sql -dir $(MIGRATIONS_DIR) -seq $(name)

## migrate-up: Apply all up migrations (usage: make migrate-up db="postgres://user:pass@localhost:5432/dbname?sslmode=disable")
.PHONY: migrate-up
migrate-up:
	@if [ -z "$(db)" ]; then \
		echo "❌ Please provide a database URL, e.g. 'make migrate-up db=postgres://user:pass@localhost:5432/db?sslmode=disable'"; \
		exit 1; \
	fi
	@echo "Applying migrations..."
	@$(MIGRATE) -path $(MIGRATIONS_DIR) -database "$(db)" up

## migrate-down: Roll back the last migration (usage: make migrate-down db="postgres://user:pass@localhost:5432/dbname?sslmode=disable")
.PHONY: migrate-down
migrate-down:
	@if [ -z "$(db)" ]; then \
		echo "❌ Please provide a database URL, e.g. 'make migrate-down db=postgres://user:pass@localhost:5432/db?sslmode=disable'"; \
		exit 1; \
	fi
	@echo "Rolling back last migration..."
	@$(MIGRATE) -path $(MIGRATIONS_DIR) -database "$(db)" down 1


## migrate-dev-up: Apply all up migrations to the local dev database
.PHONY: migrate-dev-up
migrate-dev-up:
	@echo "Applying migrations to dev database..."
	@$(MIGRATE) -path $(MIGRATIONS_DIR) -database "$(DEV_DB)" up

## migrate-dev-down: Roll back the last migration on the local dev database
.PHONY: migrate-dev-down
migrate-dev-down:
	@echo "Rolling back last migration on dev database..."
	@$(MIGRATE) -path $(MIGRATIONS_DIR) -database "$(DEV_DB)" down 1

## migrate-dev-drop: Drop all tables and migration tracking from dev database
.PHONY: migrate-dev-drop
migrate-dev-drop:
	@echo "Dropping all tables from dev database..."
	@$(MIGRATE) -path $(MIGRATIONS_DIR) -database "$(DEV_DB)" drop -f
	@echo "✅ Dev database dropped (clean slate)"

## help: Show available targets
.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Available targets:"
	@grep -E '^##' Makefile | sed -e 's/## //'

