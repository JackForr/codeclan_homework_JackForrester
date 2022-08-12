library(tidyverse)
library(shiny)
library(ggplot2)
library(CodeClanData)

years <- unique(game_sales$year_of_release)

game_sales <- CodeClanData::game_sales
view(game_sales)
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Video Game Genre Performance"),

    # Sidebar with a select year 
    sidebarLayout(
        sidebarPanel(
          br(),
          br(),
            selectInput("year_input",
                        label = "Which year?",
                        choices = years)
        ),

        # Show a plot of the generated distribution
        
        mainPanel(
          tags$h5("Avg. Games Sales by Genre"),
          br(),
          br(),
           plotOutput("sales_plot"),
          
          tags$h5("Avg. User Rating by Genre"),
          br(),
          br(),
          plotOutput("ratings_plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  output$sales_plot <- renderPlot({
    game_sales %>% 
      group_by(genre, year_of_release) %>% 
      summarise(sales = round(mean(sales), 2), .groups = "keep") %>% 
      mutate(year_of_release = as.factor(year_of_release)) %>% 
      arrange(year_of_release) %>% 
      filter(year_of_release == input$year_input) %>% 
      ggplot(aes(x = genre,
                 y = sales,
                 fill = "coral"))+
      geom_col(show.legend = F)+
      geom_text(aes(label = sales), 
                size = 4)+
      coord_flip()+
      theme(panel.grid = element_blank(),
            axis.text.x = element_blank(),
            panel.background = element_blank())+
      labs(x = "Genre",
           y = "Sales (£m)")
  })
  
  output$ratings_plot <- renderPlot({
  game_sales %>% 
    group_by(genre, year_of_release) %>% 
    summarise(user_score = round(mean(user_score), 2), .groups = "keep") %>% 
    mutate(year_of_release = as.factor(year_of_release)) %>% 
    arrange(year_of_release) %>% 
    filter(year_of_release == input$year_input) %>% 
    ggplot(aes(x = genre,
               y = user_score,
               fill = "coral"))+
    geom_col(show.legend = F)+
    geom_text(aes(label = user_score), 
              size = 4)+
    coord_flip()+
    theme(panel.grid = element_blank(),
          axis.text.x = element_blank(),
          panel.background = element_blank())+
    labs(x = "Genre",
         y = "User Score")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
