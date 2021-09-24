library(shiny)
library(shinyjs)

ui <- fluidPage(
  useShinyjs(),
  navbarPage(title = tagList("title",actionLink("sidebar_button","",icon = icon("bars"))),
             id = "navbarID",
             tabPanel("tab1",
                      div(class="sidebar"
                          ,sidebarPanel("sidebar1")
                      ),
                      mainPanel(
                        "MainPanel1"
                      )
             ),
             tabPanel("tab2",
                      div(class="sidebar"
                          ,sidebarPanel("sidebar2")
                      ),
                      mainPanel(
                        "MainPanel2"
                      )
             )
  )
)

server <-function(input, output, session) {
  
  observeEvent(input$sidebar_button,{
    shinyjs::toggle(selector = ".sidebar")
  })
  
}