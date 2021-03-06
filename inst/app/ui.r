library(shiny)

shinyUI(function(request) {
  ui <- fluidPage(theme = shinythemes::shinytheme("cerulean"),
                  titlePanel(tags$head(
                    tags$link(rel = "icon", type = "image/png", href = "hn.png"),
                    tags$title("SKDE"),
                    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                  )),
                  navbarPage(shiny::HTML("SKDE"), id = "nav",
                             tabPanel("Variasjon",
                                      uiOutput("pick_variasjon"),
                                      uiOutput("plot_variasjon")
                             ),
                             tabPanel("Kvalitet",
                                      uiOutput("pick_kvalitet"),
                                      uiOutput("pick_bo"),
                                      uiOutput("plot_kvalitet")
                             )
                  )
  )})
