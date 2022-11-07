if(!require(pacman)) install.packages(pacman)
pacman::p_load(shiny,
               shinythemes,
               shinydashboard,
               shinyWidgets,
               tidyverse,
               sf,
               maps,
               leaflet,
               RColorBrewer,
               readtext)

textBlocks <- readtext(paste0("TextBlocks/*"))


shinyUI(bootstrapPage(
  navbarPage(theme = shinytheme("sandstone"), collapsible = TRUE,
             HTML('<a style = "text-decoration:none;
                  cursor:default; 
                  color:#FFFFFF;"
                  class = "active"
                  href = "#"> RESPOND </a>'),
             id = "nav",
             windowTitle = "The RESPOND Model",
             fluid = TRUE,
             tabPanel("Introduction",
                      tags$head(tags$style(HTML('.row div {padding: 0% 1% 0% 1% !important;}'))),
                      fluidRow(
                        column(8,
                               leafletOutput("leafletMap")),
                        box(width = 4,
                            title = "One Cool Model B)",
                            background = "light-blue",
                            #Rendered text next to leaflet map
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
                            Duis laoreet ligula vel libero tristique fermentum. 
                            Quisque dictum risus in congue faucibus. 
                            Nam cursus, leo sed volutpat varius, est erat bibendum augue, eu fermentum arcu mauris eget risus. 
                            Donec sed sollicitudin magna. 
                            Mauris suscipit molestie enim at viverra. 
                            Praesent sed purus sit amet augue pharetra aliquam ut eu mi. 
                            Curabitur mauris magna, volutpat at accumsan quis, tincidunt ut nulla. 
                            Donec porta ac est sed efficitur. Integer elit sapien, laoreet quis velit sodales, tristique condimentum ex. 
                            Praesent nisl eros, feugiat malesuada pharetra quis, dignissim vitae felis.")
                      ),
                      fluidRow(
                        tags$head(tags$style(HTML('.row div {padding: 0% 1% 2% 1% !important;}'))),
                        box(width = 10,
                            title = "General Info",
                            paste(textBlocks[1,2]))
                      )),
             tabPanel("Model Structure"),
             tabPanel("References"),
             tabPanel("Passworded Tab 1")
             )
  
))