Plot_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shinycssloaders::withSpinner(plotly::plotlyOutput(ns("plot"), height = "700px"))
  )
}

Plot_server <- function(id, data) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      output$plot <- plotly::renderPlotly({
        data$trigger
        shiny::isolate(shiny::req(data$ODMdata))
        shiny::isolate(data$ODMdata) %>%
          plotly::plot_ly(
            x = ~LocalDateTime,
            y = ~DataValue,
            key = shiny::isolate(data$ODMdata$index),
            split = ~label,
            type = "scatter",
            mode = "line", 
            opacity = 0.8) %>%
          plotly::style(hoverinfo = 'none') %>%
          plotly::layout(legend = list(orientation = "h"))
      })
  
      
      plot_proxy <- plotly::plotlyProxy("plot", session)
      observe({
        plotly::plotlyProxyInvoke(plot_proxy, "deleteTraces", nrow(unique(data$ODMdata[,"label"])) + 0:1)
        plotly::plotlyProxyInvoke(plot_proxy, "addTraces", 
                                  list(x = data$ODMdata[data$ODMdata$edited == "TRUE", "LocalDateTime", drop = T], 
                                       y = data$ODMdata[data$ODMdata$edited == "TRUE", "DataValue", drop = T],
                                       type = 'scattergl',
                                       mode = 'markers',
                                       name = "edited",
                                       marker = list(
                                         color = '#eeeeee')
                                  ))                 
        plotly::plotlyProxyInvoke(plot_proxy, "addTraces", 
                                  list(x = data$ODMdata[data$ODMdata$edited == "NEW", "LocalDateTime", drop = T], 
                                       y = data$ODMdata[data$ODMdata$edited == "NEW", "DataValue", drop = T],
                                       type = 'scattergl',
                                       mode = 'markers',
                                       name = "new",
                                       marker = list(
                                         color = '#ff0000')
                                  ))
        plotly::plotlyProxyInvoke(plot_proxy, "restyle", selectedpoints = NULL)
      })
  
  selected <- reactive({
    key = plotly::event_data("plotly_selected")$key
    if(length(key) < 1) {
      key = 1:nrow(data$ODMdata)
    }
    key
  })
  
  return(selected)
    })
}
