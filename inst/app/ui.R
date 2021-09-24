ui <- shinydashboard::dashboardPage(
  shinydashboard::dashboardHeader(title = "Observation Data"),
  shinydashboard::dashboardSidebar(
    collapsed = TRUE,
    width = 600,    
    shiny::br(),
    shinydashboard::box(title = "Console", width = 12, console_ui("getConsole")
  )),
  shinydashboard::dashboardBody(
    shinydashboard::tabBox(width = "100%",
                           shiny::tabPanel(
                             title = "Series Catalog",
                             Seriescatalog_ui("getData")
                           ),
                           shiny::tabPanel(
                             title = "Plot",
                             Plot_ui("getPlot")
                           )
    )
  )
)
