server <- function(input, output, session) {
  ODMdata <- series_catalog_server("getData", connection = ODM)
  brushed <- Plot_server("getPlot", data = ODMdata)
  console_server("getConsole", data = ODMdata,
                 selected = brushed)
}
