# tinyreadings

Tinyreadings is a tech enthusiast newsletter, curated by tech lovers.

This service orchestrates the collection, curation and distribution of the newsletter.


## Development

- clone the repository
- cp .env.example .env
- docker compose up
- make migrate-dev-up
- code & build

### Make targets

| Target              | Description                                                                 |
|---------------------|-----------------------------------------------------------------------------|
| `build`            | Compile the binary                                      |
| `lint`             | Run golangci-lint to check for code issues.                                |
| `test`             | Run unit tests.                                                            |
| `clean`            | Remove built files.                                                        |
| `migrate-create`   | Create a new migration (usage: `make migrate-create name=<migration_name>`).|
| `migrate-up`       | Apply all up migrations (usage: `make migrate-up db=<database_url>`).      |
| `migrate-down`     | Roll back the last migration (usage: `make migrate-down db=<database_url>`).|
| `migrate-dev-up`   | Apply all up migrations to the local dev database.                         |
| `migrate-dev-down` | Roll back the last migration on the local dev database.                    |
| `migrate-dev-drop` | Drop all tables and migration tracking from the dev database.              |
| `help`             | Show available targets.                                                    |

