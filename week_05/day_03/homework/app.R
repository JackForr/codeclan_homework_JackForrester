library(ggplot2)
library(tidyverse)
library(shiny)
library(bslib)

scottish_exports <- CodeClanData::scottish_exports

sector <- unique(scottish_exports$sector)
all_sectors <- scottish_exports %>% 
  select(sector)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  theme = bs_theme(bootswatch = "journal"),
  
  # Application title
  titlePanel(tags$h1("Scottish Exports")),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      br(),
      br(),
      selectInput(inputId = "sector_input",
                  label = "What sector?",
                  choices = sector
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel = mainPanel(
      tags$h2("Sector Growth"),
      br(),
      br(),
      plotOutput("export_plot"),
      
      tags$a("Scottish Gov", href = "https://www.gov.scot/publications/export-statistics-scotland-2019/")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$export_plot <- renderPlot({
    scottish_exports%>% 
      filter(sector == input$sector_input) %>% 
      ggplot(aes(x = year,
                 y = exports,
                 colour = sector))+
      geom_line()+
      theme_linedraw()+
      labs(x = "Year",
           y = "Export Volume")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
