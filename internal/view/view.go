package view

import (
	"html/template"
	"io"

	"github.com/labstack/echo/v4"
	"github.com/rs/zerolog/log"
)

type Template struct {
	templates *template.Template
}

func New(templates *template.Template) *Template {
	return &Template{
		templates: templates,
	}
}

func (t *Template) Render(w io.Writer, name string, data interface{}, c echo.Context) error {

	log.Info().Str("name", name).Msg("render template")

	return t.templates.ExecuteTemplate(w, name, data)
}
