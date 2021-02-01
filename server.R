
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(plotly)
library("rnoaa")

shinyServer(function(input, output) {

  output$plot <- renderPlotly({
    input$goButton
    

    isolate({
    #(Tortosa <- ghcnd(stationid = "SP000009981"))
    #(Reus<-ghcnd(stationid = "SPE00120530"))
    #(Barcelona<-ghcnd(stationid = "SP000008181"))
    monitorsReus <- "SPE00120530"
    z<-input$date1
    d<-input$numDays-1
    all_monitors_clean <- meteo_pull_monitors(monitorsReus,
                                              date_min = z,
                                              date_max = z + d) %>%
      rename(day = date,
             location = id)
    all_monitors_clean %>% head() %>% knitr::kable()
    plotReus<-all_monitors_clean[,c(2:6)]
    plotReus["Station"]<-"Reus"
    plotReus$tmax <- plotReus$tmax/10
    plotReus$tmin <- plotReus$tmin/10
    plotReus$tavg <- plotReus$tavg/10
    monitorsTortosa <- "SP000009981"
    z<-input$date1
    d<-input$numDays-1
    all_monitors_clean <- meteo_pull_monitors(monitorsTortosa,
                                              date_min = z,
                                              date_max = z + d) %>%
      rename(day = date,
             location = id)
    all_monitors_clean %>% head() %>% knitr::kable()
    plotTortosa<-all_monitors_clean[,c(2:6)]
    plotTortosa["Station"]<-"Tortosa"
    plotTortosa$tmax <- plotTortosa$tmax/10
    plotTortosa$tmin <- plotTortosa$tmin/10
    plotTortosa$tavg <- plotTortosa$tavg/10
    monitorsBarcelona <- "SP000008181"
    z<-input$date1
    d<-input$numDays-1
    all_monitors_clean <- meteo_pull_monitors(monitorsBarcelona,
                                              date_min = z,
                                              date_max = z + d) %>%
      rename(day = date,
             location = id)
    plotBarcelona<-all_monitors_clean[,c(2:6)]
    plotBarcelona["Station"]<-"Barcelona"
    plotBarcelona$tmax <- plotBarcelona$tmax/10
    plotBarcelona$tmin <- plotBarcelona$tmin/10
    plotBarcelona$tavg <- plotBarcelona$tavg/10
    dataStations<-rbind(plotReus,plotTortosa)
    dataStations<-rbind(plotBarcelona,dataStations)
    if(identical(input$data1, "bcn")){ plot_ly(plotBarcelona, x = ~day, y = ~tavg, color = ~Station, type = 'scatter', mode = 'lines', 
                                               showlegend = TRUE )%>%
        layout(title = "Average Temperatures in Barcelona (Spain)",
               paper_bgcolor='rgb(255,255,255)', plot_bgcolor='rgb(229,229,229)',
               xaxis = list(title = "Days",
                            gridcolor = 'rgb(255,255,255)',
                            showgrid = TRUE,
                            showline = FALSE,
                            tickcolor = 'rgb(127,127,127)',
                            ticks = 'outside',
                            zeroline = FALSE),
               yaxis = list(title = "Temperature (degrees C)",
                            gridcolor = 'rgb(255,255,255)',
                            showgrid = TRUE,
                            showline = FALSE,
                            tickcolor = 'rgb(127,127,127)',
                            ticks = 'outside',
                            zeroline = FALSE))
    } else { if(identical(input$data1, "reus")){plot_ly(plotReus, x = ~day, y = ~tavg, color = ~Station, type = 'scatter', mode = 'lines', 
                     showlegend = TRUE )%>%
        layout(title = "Average Temperatures in Reus (Spain)",
               paper_bgcolor='rgb(255,255,255)', plot_bgcolor='rgb(229,229,229)',
               xaxis = list(title = "Days",
                            gridcolor = 'rgb(255,255,255)',
                            showgrid = TRUE,
                            showline = FALSE,
                            tickcolor = 'rgb(127,127,127)',
                            ticks = 'outside',
                            zeroline = FALSE),
               yaxis = list(title = "Temperature (degrees C)",
                            gridcolor = 'rgb(255,255,255)',
                            showgrid = TRUE,
                            showline = FALSE,
                            tickcolor = 'rgb(127,127,127)',
                            ticks = 'outside',
                            zeroline = FALSE))
    } else {if(identical(input$data1, "tor")){{ plot_ly(plotTortosa, x = ~day, y = ~tavg, color = ~Station, type = 'scatter', mode = 'lines', 
                     showlegend = TRUE )%>%
        layout(title = "Average Temperatures in Tortosa (Spain)",
               paper_bgcolor='rgb(255,255,255)', plot_bgcolor='rgb(229,229,229)',
               xaxis = list(title = "Days",
                            gridcolor = 'rgb(255,255,255)',
                            showgrid = TRUE,
                            showline = FALSE,
                            tickcolor = 'rgb(127,127,127)',
                            ticks = 'outside',
                            zeroline = FALSE),
               yaxis = list(title = "Temperature (degrees C)",
                            gridcolor = 'rgb(255,255,255)',
                            showgrid = TRUE,
                            showline = FALSE,
                            tickcolor = 'rgb(127,127,127)',
                            ticks = 'outside',
                            zeroline = FALSE))}
   
    }}}
    
})
  })
  observeEvent(input$helpButton, {
    output$text1 <- renderText({"Select the first day to be shown in the
graphic"})
    output$text2 <- renderText({"Select from the three cities on the list 
and the graphic will display its data"})
    output$text3 <- renderText({"Select the number of days for data to be 
displayed in the graphic (minimum 1, 
maximum 60)"})
    output$text0 <- renderText({"This app shows the average daily temperature in three spanish cities from 01/01/2006 until 03/07/2017"})
    output$textShow <- renderText({"Use this button once you have selected 
all the variables to plot a new graphic"})
})
  observeEvent(input$hideButton, {
    output$text1 <- renderText({""})
    output$text2 <- renderText({""})
    output$text3 <- renderText({""})
    output$text0 <- renderText({""})
    output$textShow <- renderText({""})
    })  
})