# Load data

# LOADDATA <- F
# 
# if(LOADDATA){
#   source("~/Loss Data/R/Dashboards/speed_reader/sr_pipeline.R")
# }


# Load UI

ui <- eval(parse("~/Loss Data/R/Dashboards/speed_reader/sr_ui.R"))

# Load server
server <- function(input, output) {
  
  eval(parse("~/Loss Data/R/Dashboards/speed_reader/sr_server.R"))
  
}

# Run the application 
shinyApp(ui = ui, server = server)
