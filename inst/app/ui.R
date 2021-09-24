ui <- shinydashboard::dashboardPage(
  shinydashboard::dashboardHeader(title = "Observation Data"),
  shinydashboard::dashboardSidebar(
    collapsed = TRUE,
    width = 600,    
    shiny::br(),
    shinydashboard::box(title = "Console", width = 12, console_ui("getConsole")
  )),
  shinydashboard::dashboardBody(
    tags$head(
      HTML(
        "
          <script>
          var socket_timeout_interval
          var n = 0
          $(document).on('shiny:connected', function(event) {
          socket_timeout_interval = setInterval(function(){
          Shiny.onInputChange('count', n++)
          }, 1500)
          });
          $(document).on('shiny:disconnected', function(event) {
          clearInterval(socket_timeout_interval)
          });
          </script>
          "
      )
    ),
    textOutput("keepAlive"),
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
