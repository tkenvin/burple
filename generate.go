package main

import (
    "text/template"
    "os"
    "github.com/iancoleman/strcase"
    "strings"
    "fmt"
)

var validLangs = map[string]bool{ "cs": true, "ts": true, }

func main() {
    arguments := os.Args[1:]
    argumentCount := len(arguments)
    if argumentCount != 1 {
        panic(fmt.Sprintf("Need exactly one argument, %d provided", argumentCount))
    }
    language := arguments[0]
    valid, known := validLangs[language]
    if !(known && valid) {
        panic(fmt.Sprintf("%s is either not known or not valid", language))
    }

    printForLanguage(language)
}

func printForLanguage(language string) {
    funcMap := template.FuncMap {
		"camel": camel,
    }
    templateFileName := fmt.Sprintf("%s.tpl", language)
    tpl, err := template.New(templateFileName).Funcs(funcMap).ParseFiles(templateFileName)
    if err != nil { panic(err) }
    err = tpl.Execute(os.Stdout, XkcdColours)
    if err != nil { panic(err) }
}

func camel(s string) string {
    return strcase.ToCamel(
        strings.ReplaceAll(s, "/", " slash "))
}
