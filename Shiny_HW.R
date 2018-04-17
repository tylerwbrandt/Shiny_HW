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
      helpText("Here are the results of presidential forecasts from 1952-2008"),
      
      # Input: Selector for Forecast model to plot with Actual results ----
      selectInput("variable", "Forecast model:",
                  c("Campbell",
                    "Lewis-Beck",
                    "EWT2C2",
                    "Fair",
                    "Hibbs",
                    "Abramowitz"))
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: HTML table with requested number of observations ----
      tableOutput("view"),
      
      # Output: Plot the election results
      plotOutput("plot", click = "plot_click"),
      verbatimTextOutput("info")
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
  
  # Plot the actual results
  output$plot <- renderPlot({
    plot(as.numeric(row.names(presidentialForecast)), presidentialForecast$Actual,
         xlab = "Year", ylab = "Voting Percentage", col = "blue", main = "Voting Percentage by Year")
    if (input$variable == "Campbell"){
      points(as.numeric(row.names(presidentialForecast)), presidentialForecast$Campbell, col = "red")
    } else if (input$variable == "Lewis-Beck"){
      points(as.numeric(row.names(presidentialForecast)), presidentialForecast$`Lewis-Beck`, col = "red")
    } else if (input$variable == "EWT2C2"){
      points(as.numeric(row.names(presidentialForecast)), presidentialForecast$EWT2C2, col = "red")
    } else if (input$variable == "Fair"){
      points(as.numeric(row.names(presidentialForecast)), presidentialForecast$Fair, col = "red")
    } else if (input$variable == "Hibbs"){
      points(as.numeric(row.names(presidentialForecast)), presidentialForecast$Hibbs, col = "red")
    } else {
      points(as.numeric(row.names(presidentialForecast)), presidentialForecast$Abramowitz, col = "red")
    }
    legend("topright", legend = c("Actual", input$variable),
           col = c("blue", "red"), pch = c(1,1))
  })
  
  # Output click info
  output$info <- renderText({
    paste0("Year =", input$plot_click$x, "\nVoting Percentage =", input$plot_click$y)
  })
  
}

# Create Shiny app ----
shinyApp(ui = ui, server = server)
