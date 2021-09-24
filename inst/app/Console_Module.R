console_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::tags$head(shiny::tags$style(
      shiny::HTML(
        '#getConsole-eval{margin-top: 25px; background-color:orange}'
      )
    )),
    shinyAce::aceEditor(ns("code"), mode = "r", height = 200, theme = "idle_fingers"),
    shiny::actionButton(ns("eval"), "Evaluate"),
    shiny::br(),
    shiny::br(),
    shiny::verbatimTextOutput(ns("output")),
    tabsetPanel(
      tabPanel("basics", shiny::helpText(shiny::includeMarkdown("examples/basics.md"))),
      tabPanel("uploads", shiny::helpText(shiny::includeMarkdown("examples/upload.md"))),
      tabPanel("stats", shiny::helpText(shiny::includeMarkdown("examples/statistics.md"))),
      tabPanel("qualifiers", shiny::helpText(shiny::includeMarkdown("examples/qualifiers.md")))
    )
  )
}

console_server <- function(id, data, selected) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      DataValues <- reactive({data$ODMdata})
      Selected <- reactive({data$ODMdata[selected(),]})
      Upsert <- function(insert) {
        data$ODMdata <- data$ODMdata %>%
          dplyr::mutate(edited = dplyr::if_else(index %in% insert$index, "TRUE", edited)) %>%
          dplyr::bind_rows(insert %>%
                             dplyr::mutate(edited = "NEW")) %>% dplyr::mutate(index = 1:nrow(.))
      }
      shiny::observe({
        shinyAce::updateAceEditor(session, "code",
                                  shiny::isolate(eval(parse(text = input$code))),
                                  mode = "r"
        )
      })
      output$output <- shiny::renderPrint({
        input$eval
        return(shiny::isolate(eval(
          parse(text = stringr::str_replace_all(input$code, "[\r]", ""))
        )))
      })
    })
}
