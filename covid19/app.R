# Shiny app for COVID-19 Number of cases around the world per country.
# By Sergio Iván Arroyo Giles
# October, 23th 2020

library(shiny)
library(tidyverse)
library(reshape2)
library(plotly)
library(leaflet)

# Load part of the database

filePath <- "Covid_confirmed.csv"
datosCovid <- read.csv(filePath, nrows = 10)
n_col <- ncol(datosCovid) 

#' Only the first 2 columns have char values and the rest of them are numeric

CLASSES <- rep(c("character", "numeric"), c(2, n_col - 2))

#' Load complete database

datosCovid <- read.csv(filePath, colClasses = CLASSES)
allCountries <- unique(datosCovid$Country.Region)

#' Spread all dates along each country (tidy data) and format date 

datosCovid <- datosCovid %>% 
    melt(c(1:4), c(5:(n_col)), 
         variable.name = "Date", value.name = "Count") %>% 
    arrange(Country.Region) 

datosCovid <- datosCovid %>% 
                mutate_at(c("Date"),
                          function(x) x %>%
                              gsub(pattern = "X", replacement = "") %>%
                              gsub(pattern = "\\.", replacement = "/") %>%
                              as.Date(format = "%m/%d/%y"))

datosCovid2 <- datosCovid %>%
                group_by(Country.Region, Date) %>% 
                summarise(Count = sum(Count),
                          Lat = mean(Lat),
                          Long = mean(Long))

minDate <- datosCovid$Date %>% unique() %>% min()
maxDate <- datosCovid$Date %>% unique() %>% max()

ui <- fluidPage(
    
    navbarPage(
        title = "COVID-19",
        tabPanel("Number of cases", 
            sidebarLayout(
                sidebarPanel(
                    selectizeInput("country", "Select a Country", 
                                   choices = allCountries, options = ),
                    radioButtons("scale", "Select a Scale", 
                                 choices = c("Normal", "Logarithmic")),
                    selectInput("compareCountry", "Select another Country to Compare",
                                choices = c("", allCountries), selected = "")
                ),
                
                mainPanel(
                    plotlyOutput("timeSeriePlot")
                )
            )
        ),
        tabPanel("Map by Date",
            sidebarLayout(
                sidebarPanel(
                    dateInput("date", "Pick a Date", min = minDate, 
                              max = maxDate, value = maxDate, ),
                    sliderInput("size", "Control the Size of Circles", min = 10,
                                max = 50, ticks = F, step = 2, value = 20)
                ),
                
                mainPanel(
                    leafletOutput("mapCircles")
                )
                     
            )
        )
        
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$timeSeriePlot <- renderPlotly({
        p <- datosCovid2 %>% 
            filter(Country.Region %in% 
                       c(input$country, input$compareCountry)) %>% 
            ggplot() + 
            geom_line(aes(x=Date, y = Count, 
                          color = factor(Country.Region), 
                          text = sprintf(paste("Country: %s",
                                               "Date: %s",
                                               "Number of cases: %s", sep = "<br>"),
                                         Country.Region, Date, Count))) +
            geom_line(aes(x=Date, y = Count, 
                          color = factor(Country.Region))) +
            xlab("Date") + theme(legend.position = "") + labs(color = "Country")
        
        if (input$scale == "Logarithmic") {
            q <- p + scale_y_log10() + ylab("Number of cases (log)")
        }else{
            q <- p + ylab("Number of cases")
        }
        ggplotly(q, tooltip = "text") %>%
            layout(hovermode = 'compare')
    })
    output$mapCircles <- renderLeaflet({
        leaflet(datosCovid2 %>% filter(Date == input$date & Count != 0)) %>% 
            addTiles() %>%
            addCircleMarkers(~Long, ~Lat, label = ~as.character(
                paste(Country.Region, 
                      scales::number(Count, big.mark = ",", accuracy = NULL))), 
                radius = ~as.numeric((input$size)*log(Count/max(Count)+1)), 
                stroke = T, 
                weight = 0.5)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
