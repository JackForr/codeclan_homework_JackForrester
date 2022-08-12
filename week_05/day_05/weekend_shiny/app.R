library(tidyverse)
library(shiny)
library(ggplot2)
library(CodeClanData)
library(plotly)
library(bslib)

years <- unique(game_sales$year_of_release)
genres <- unique(game_sales$genre)

game_sales <- CodeClanData::game_sales

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Video Game Genre Performance"),
  
  # Select year 
  selectInput("year_input",
              label = "Which year?",
              choices = years),
  
  # Static Genre Plots
  fluidRow(
    column(6,
           tags$h5("Avg. Games Sales by Genre"),
           br(),
           br(),
           plotlyOutput("sales_plot")),
    
    column(6,
           tags$h5("Avg. User Rating by Genre"),
           br(),
           br(),
           plotlyOutput("ratings_plot")
    )
  ),
  
  #Select genre
  selectInput("genre_input",
              label = "Which genre?",
              choices = genres),
  
  #Genre plots over time
  fluidRow(
    column(6,
           tags$h5("Avg. Sales"),
           br(),
           br(),
           plotlyOutput("sales_time_plot")),
    
    column(6,
           tags$h5("Avg. ratings"),
           br(),
           br(),
           plotlyOutput("ratings_time_plot"))
  )
  
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$sales_plot <- renderPlotly({
    game_sales %>% 
      group_by(genre, year_of_release) %>% 
      summarise(sales = round(mean(sales), 2), .groups = "keep") %>% 
      mutate(year_of_release = as.factor(year_of_release)) %>% 
      arrange(year_of_release) %>% 
      filter(year_of_release == input$year_input) %>% 
      ggplot(aes(x = genre,
                 y = sales,
                 fill = "coral"))+
      geom_col()+
      coord_flip()+
      theme(panel.grid = element_blank(),
            panel.background = element_blank(),
            legend.position = "none")+
      labs(x = "Genre",
           y = "Sales (£m)")
  })
  
  output$ratings_plot <- renderPlotly({
    game_sales %>% 
      group_by(genre, year_of_release) %>% 
      summarise(user_score = round(mean(user_score), 2), .groups = "keep") %>% 
      mutate(year_of_release = as.factor(year_of_release)) %>% 
      arrange(year_of_release) %>% 
      filter(year_of_release == input$year_input) %>% 
      ggplot(aes(x = genre,
                 y = user_score,
                 fill = "coral"))+
      geom_col()+
      coord_flip()+
      theme(panel.grid = element_blank(),
            panel.background = element_blank(),
            legend.position = "none")+
      labs(x = "Genre",
           y = "User Score")
  })
  
  output$sales_time_plot <- renderPlotly({
    game_sales %>% 
      group_by(genre, year_of_release) %>% 
      summarise(sales = round(mean(sales), 2), .groups = "keep") %>% 
      filter(genre == input$genre_input) %>% 
      ggplot(aes(x = year_of_release,
                 y = sales,
                 colour = genre))+
      geom_line(show.legend = F)+
      geom_point()+
      theme(panel.grid = element_blank(),
            panel.background = element_blank())+
      labs(x = "Release Year",
           y = "Sales (£m)")
  })
  
  output$ratings_time_plot <- renderPlotly({
    game_sales %>% 
      group_by(genre, year_of_release) %>% 
      summarise(user_score = round(mean(user_score), 2), .groups = "keep") %>%
      filter(genre == input$genre_input) %>% 
      ggplot(aes(x = year_of_release,
                 y = user_score,
                 colour = genre))+
      geom_line(show.legend = F)+
      geom_point()+
      theme(panel.grid = element_blank(),
            panel.background = element_blank())+
      labs(x = "Release Year",
           y = "User Score")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
