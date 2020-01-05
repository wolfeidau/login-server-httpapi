package main

import (
	"html/template"
	"net/http"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/labstack/echo/v4"
	"github.com/wolfeidau/login-server-httpapi/internal/echoadapter"
	"github.com/wolfeidau/login-server-httpapi/internal/view"
)

func Index(c echo.Context) error {
	return c.Render(http.StatusOK, "index.html", "World")
}

func main() {

	e := echo.New()
	e.Renderer = view.New(template.Must(template.ParseGlob("./public/views/*.html")))
	e.GET("/index", Index)

	echolambda := echoadapter.New(e)

	lambda.Start(echoadapter.Handler(echolambda))
}
