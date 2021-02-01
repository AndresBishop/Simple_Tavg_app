
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotly)

xdate<-"2017-01-01"
shinyUI(fluidPage(
  
  textOutput("SliderText"),

  # Application title
  titlePanel("Average daily temperature"),
  tags$h6("data from GHCN"),
  tags$style(type='text/css', '#text0 {color: orange;}'),
  verbatimTextOutput('text0'),
  

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    
    sidebarPanel(
      dateInput('date1',label = "Beginning day: ",
                value = "2016-01-01",
                min = "2006-01-01" , max = "2021-12-31",
                format = "yyyy-mm-dd", startview = "year"
      ),
      tags$style(type='text/css', '#text1 {color: orange;}'),
      verbatimTextOutput('text1'),
      selectInput("data1", "City:",selected = "bcn",
                  c("Barcelona" = "bcn",
                    "Reus" = "reus",
                    "Tortosa" = "tor")),
      tags$style(type='text/css', '#text2 {color: orange;}'), 
      verbatimTextOutput('text2'),
      sliderInput("numDays",
                  "Number of days to display:",
                  min = 1,
                  max = 60,
                  value = 30),
      tags$style(type='text/css', '#text3 {color: orange;}'),
      verbatimTextOutput('text3'),
      tags$br(),
      tags$style(type='text/css', '#goButton {background-color: #428bca;color:white;}'),
      actionButton("goButton", "Show graphic!"),
      tags$style(type='text/css', '#textShow {color: orange;}'), 
      tags$br(),
      verbatimTextOutput('textShow'),
      tags$br(),
      tags$style(type='text/css', '#helpButton {background-color: orange;}'),
      actionButton("helpButton", "Show help"),
      tags$style(type='text/css', '#hideButton {color: orange;}'),
      actionButton("hideButton", "Hide help")
     
        
      
    ),
    
    

    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("plot")
     
    )
  )
))
