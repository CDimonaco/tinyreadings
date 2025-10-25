package issue

import "gorm.io/gorm"

type Link struct {
	gorm.Model
	ID        string
	Url       string
	CreatedBy string
}
