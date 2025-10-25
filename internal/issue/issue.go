package issue

import "gorm.io/gorm"

type Issue struct {
	gorm.Model
	ID          string
	Title       string
	Description string
	ImageURL    string
	LinkID      string
	Link        Link
}
