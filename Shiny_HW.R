library(shiny)
install.packages("EBMAforecast")
library(EBMAforecast)

## Shiny Assignment for Tuesday 4/17/18

## 1. Create a ui that does nothing
# Define UI for dataset viewer app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Presidential Forecasts"),
  
  # Sidebar layout with a input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      
      # Include Clarifying Text
      helpText("Here are the results of presidential forecasts from 1952-2008")
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: HTML table with requested number of observations ----
      tableOutput("view")
    )
  )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
  library(EBMAforecast)
  data("presidentialForecast")
  
  # Show the first "n" observations ----
  output$view <- renderTable({
    presidentialForecast
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
